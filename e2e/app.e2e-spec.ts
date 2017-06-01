import { KisanSevaAngular4Page } from './app.po';

describe('kisan-seva-angular4 App', () => {
  let page: KisanSevaAngular4Page;

  beforeEach(() => {
    page = new KisanSevaAngular4Page();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
