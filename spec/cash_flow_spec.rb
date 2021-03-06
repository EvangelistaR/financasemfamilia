require 'rails_helper'

feature 'The app generate a partial cash flow' do
  scenario 'successfully' do
    user = create(:user, password: '123456')
    user2 = create(:user, email: 'test8428@gmail.com')
    create(:revenue, user: user)
    create(:expense, user: user)
    create(:expense, date: '01/07/2018',
                     description: 'Compra de calça jeans',
                     expense_type: 'Vestuário e acessórios',
                     value: '50,00', user: user2)

    login_as(user)
    visit root_path

    within('.navbar') do
      click_on 'Inserir Ganhos'
    end

    fill_in 'Data', with: '15/07/2018'
    fill_in 'Descrição', with: 'Pagamento de férias'
    fill_in 'Valor', with: '2000,00'
    select 'Férias', from: 'Tipo'

    click_on 'Registrar'

    expect(current_path).to eq cash_flow_path
    expect(page).to have_content('Entrada de recursos cadastrada')
    expect(page).to have_css('h3', text: 'Julho de 2018')
    expect(page).to have_css('th', text: 'Dia')
    expect(page).to have_css('td', text: '01/07/2018 Dom')
    expect(page).to have_css('td', text: '05/07/2018 Qui')
    expect(page).to have_css('td', text: '10/07/2018 Ter')
    expect(page).to have_css('td', text: '15/07/2018 Dom')
    expect(page).to have_css('th', text: 'Ganhos')
    expect(page).to have_css('td', text: 'R$ 0,00')
    expect(page).to have_css('td', text: 'R$ 5.000,00')
    expect(page).to have_css('td', text: 'R$ 2.000,00')
    expect(page).to have_css('th', text: 'Gastos')
    expect(page).to have_css('td', text: 'R$ 0,00')
    expect(page).to have_css('td', text: '- R$ 110,00')
    expect(page).to have_css('th', text: 'Descrição Ganhos')
    expect(page).to have_css('td', text: 'Salário')
    expect(page).to have_css('td', text: 'Férias')
    expect(page).to have_css('th', text: 'Descrição Gastos')
    expect(page).to have_css('td', text: 'Alimentação | Vestuário e acessó')
    expect(page).to have_css('p', text: 'Total de ganhos: R$ 7.000,00')
    expect(page).to have_css('p', text: 'Total de gastos: - R$ 110,00')
    expect(page).to have_css('p', text: 'Total do mês: R$ 6.890,00')
  end

  scenario '' do
    visit cash_flow_path

    expect(current_path).to eq(user_session_path)
  end
end
