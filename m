Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358C01270F4
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 23:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLSWxr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 17:53:47 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64903 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSWxr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Dec 2019 17:53:47 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 497cfa437542538e; Thu, 19 Dec 2019 23:53:44 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH] ACPICA: Update the list of maintainers
Date:   Thu, 19 Dec 2019 23:53:44 +0100
Message-ID: <18147806.IHdYjMWO1X@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The Erik's last name and email address have changed recently,
so update MAINTAINERS and .mailmap to reflect that change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 .mailmap    |    1 +
 MAINTAINERS |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -345,7 +345,7 @@ F:	drivers/acpi/apei/
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	Robert Moore <robert.moore@intel.com>
-M:	Erik Schmauss <erik.schmauss@intel.com>
+M:	Erik Kaneda <erik.kaneda@intel.com>
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
 L:	linux-acpi@vger.kernel.org
 L:	devel@acpica.org
Index: linux-pm/.mailmap
===================================================================
--- linux-pm.orig/.mailmap
+++ linux-pm/.mailmap
@@ -74,6 +74,7 @@ Dmitry Safonov <0x7f454c46@gmail.com> <d
 Domen Puncer <domen@coderock.org>
 Douglas Gilbert <dougg@torque.net>
 Ed L. Cashin <ecashin@coraid.com>
+Erik Kaneda <erik.kaneda@intel.com> <erik.schmauss@intel.com>
 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 Felipe W Damasio <felipewd@terra.com.br>
 Felix Kuhling <fxkuehl@gmx.de>



