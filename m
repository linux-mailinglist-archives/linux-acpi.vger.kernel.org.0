Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1472721514D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Jul 2020 05:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgGFDNX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Jul 2020 23:13:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12422 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728641AbgGFDNX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jul 2020 23:13:23 -0400
X-UUID: 5b6e781e7a5a4890a4b688aee2f9ed50-20200706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=rI2cSHjQuS/pF7F/Z4krS5142urYzV5+3cIRuS8ygxo=;
        b=inyypq31fagcP7tD51yXniVb6xe+PN9WY1mWviZPj5s0E/4jUyf6C2sdV1MjdpifQoNOwrbV5RMxEq7alFKemWLr2sk/Wa99WO5F3SU2sqAo+8izSGVEXMnIH1hJG98IzazSheWQet61m5gHorkSFdGsEij4aNHwuQMzwDQU5R4=;
X-UUID: 5b6e781e7a5a4890a4b688aee2f9ed50-20200706
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 209215162; Mon, 06 Jul 2020 11:13:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Jul 2020 11:13:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 11:13:18 +0800
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
Subject: [PATCH v2] cpuidle: Fix CFI failure
Date:   Mon, 6 Jul 2020 11:13:15 +0800
Message-ID: <1594005196-16327-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Y2hhbmdlcyBzaW5jZSB2MToNCi0gYWRkIG1vcmUgZGVzY3JpcHRpb24gaW4gY29tbWl0IG1lc3Nh
Z2UuDQoNCioqKiBCTFVSQiBIRVJFICoqKg0KDQpOZWFsIExpdSAoMSk6DQogIGNwdWlkbGU6IGNo
YW5nZSBlbnRlcl9zMmlkbGUoKSBwcm90b3R5cGUNCg0KIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3Jf
aWRsZS5jICAgfCA2ICsrKystLQ0KIGRyaXZlcnMvY3B1aWRsZS9jcHVpZGxlLXRlZ3JhLmMgfCA4
ICsrKysrLS0tDQogZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYyAgICAgICB8IDYgKysrKy0tDQog
aW5jbHVkZS9saW51eC9jcHVpZGxlLmggICAgICAgICB8IDYgKysrLS0tDQogNCBmaWxlcyBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE4LjANCg==

