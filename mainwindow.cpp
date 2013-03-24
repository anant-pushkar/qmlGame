#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent)
{
  /* you need both these lines for a transparent main window */
  setAttribute(Qt::WA_TranslucentBackground);
  setStyleSheet("background:transparent;");

  /* turn off window decorations */
  setWindowFlags(Qt::FramelessWindowHint);

  ui = new QDeclarativeView;
  ui->setSource(QUrl("qrc:/ui.qml"));

  /* resize the root object in the QML UI definition
   * to fill the window; the alternative (and default) setting
   * is SizeViewToRootObject, which sizes
   * the view to the top-level QML element
   */
  this->ui->setResizeMode(QDeclarativeView::SizeRootObjectToView);
  QObject::connect((QObject*)ui->engine(), SIGNAL(quit()), this, SLOT(showMinimized()));

  /* maximize window */
  showMaximized();

  setCentralWidget(ui);
}

MainWindow::~MainWindow()
{
    delete ui;
}
