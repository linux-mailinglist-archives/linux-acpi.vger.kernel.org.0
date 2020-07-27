Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710022E466
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 05:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG0DZw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Jul 2020 23:25:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23218 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726701AbgG0DZw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Jul 2020 23:25:52 -0400
X-UUID: ed7933e00dc847e383996d2f93d14690-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eSopwLpH/77DG0bJJS5cJFVvSCyQIzU5BBA1AxHDxlA=;
        b=a1ck6GHoJ6jLtLN3ma2OO38vM0av3wzNJHxpBikaAeOyA/qOmNOzDx4PAej1Xk4CRugb+ZheHT7dHCR9HkW6dcz9uX9Dg3C91BvzCW6Sa0PPNRhkGa++xQvBYcgSAv3WBnM68S+8g5KtzPMkR05ms1pNbhudAZD3U6ej1sfGOUc=;
X-UUID: ed7933e00dc847e383996d2f93d14690-20200727
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 297905851; Mon, 27 Jul 2020 11:25:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 11:25:47 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 11:25:47 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <linux-acpi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v3] cpuidle: Fix CFI failure
Date:   Mon, 27 Jul 2020 11:25:45 +0800
Message-ID: <1595820346-4361-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D08AD23496ADA7D400167910677C0DCFFBB567C0F76E1255568C6D18DA940D892000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Y2hhbmdlcyBzaW5jZSB2MjoNCi0gYWRkIG1vcmUgY29tbWVudHMgb24gZW50ZXJfczJpZGxlIHRv
IGV4cGxhaW4gd2h5IGl0IGlzIG5lY2Vzc2FyeSB0byByZXR1cm4NCiAgaW50IGV2ZW4gaWYgaXRz
IHJldHVybiB2YWx1ZSBpcyBuZXZlciB1c2VkLg0KDQpjaGFuZ2VzIHNpbmNlIHYxOg0KLSBhZGQg
bW9yZSBkZXNjcmlwdGlvbiBpbiBjb21taXQgbWVzc2FnZS4NCg0KKioqIEJMVVJCIEhFUkUgKioq
DQoNCk5lYWwgTGl1ICgxKToNCiAgY3B1aWRsZTogY2hhbmdlIGVudGVyX3MyaWRsZSgpIHByb3Rv
dHlwZQ0KDQogZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMgICB8IDYgKysrKy0tDQogZHJp
dmVycy9jcHVpZGxlL2NwdWlkbGUtdGVncmEuYyB8IDggKysrKystLS0NCiBkcml2ZXJzL2lkbGUv
aW50ZWxfaWRsZS5jICAgICAgIHwgNiArKysrLS0NCiBpbmNsdWRlL2xpbnV4L2NwdWlkbGUuaCAg
ICAgICAgIHwgOSArKysrKystLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyks
IDEwIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTguMA0K

