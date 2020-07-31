Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E79233DC2
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgGaDjL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jul 2020 23:39:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731199AbgGaDjJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2020 23:39:09 -0400
X-UUID: 900d5a9cec694ea3b38005d46e34a007-20200731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1ERRm3aXwOnbFAuF3CGICnm9rLGKEtIUDiGMxxFg0OM=;
        b=YM3g9zUhNE4RO4twTYyzLRvTU/yLXrKX82OY6uk5FyK3tNtzp0YKC5b9c4KEOEsTMQj6J2gsRsRjyf2ZWL0S1onBr08e1UN5VtOTBGn0aGpXvFhsD7iCFWsk/E58zse21Sssboaj2JHdLJdyJ8XuIB5WKn4TqRdkU6vWV2Fzlwk=;
X-UUID: 900d5a9cec694ea3b38005d46e34a007-20200731
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1071401226; Fri, 31 Jul 2020 11:39:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 31 Jul 2020 11:39:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 31 Jul 2020 11:39:06 +0800
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
Subject: [PATCH] acpi: fix 'return' with no value build warning
Date:   Fri, 31 Jul 2020 11:39:04 +0800
Message-ID: <1596166744-2954-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1596166744-2954-1-git-send-email-neal.liu@mediatek.com>
References: <1596166744-2954-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Rml4aW5nIENGSSBpc3N1ZSB3aGljaCBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCBlZmU5NzExMjE0ZTYg
aXMNCmluY29tcGxldGUuDQpBZGQgcmV0dXJuIHZhbHVlIHRvIGZpeCByZXR1cm4tdHlwZSBidWls
ZCB3YXJuaW5nLg0KDQpTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8bmVhbC5saXVAbWVkaWF0ZWsu
Y29tPg0KLS0tDQogZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMgfCAgICA0ICsrLS0NCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9pZGxlLmMgYi9kcml2ZXJzL2FjcGkvcHJvY2Vz
c29yX2lkbGUuYw0KaW5kZXggNmZmYjZjOS4uNjg3MDAyMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
YWNwaS9wcm9jZXNzb3JfaWRsZS5jDQorKysgYi9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUu
Yw0KQEAgLTY2NCwxMSArNjY0LDExIEBAIHN0YXRpYyBpbnQgYWNwaV9pZGxlX2VudGVyX3MyaWRs
ZShzdHJ1Y3QgY3B1aWRsZV9kZXZpY2UgKmRldiwNCiAJCXN0cnVjdCBhY3BpX3Byb2Nlc3NvciAq
cHIgPSBfX3RoaXNfY3B1X3JlYWQocHJvY2Vzc29ycyk7DQogDQogCQlpZiAodW5saWtlbHkoIXBy
KSkNCi0JCQlyZXR1cm47DQorCQkJcmV0dXJuIC1FRkFVTFQ7DQogDQogCQlpZiAocHItPmZsYWdz
LmJtX2NoZWNrKSB7DQogCQkJYWNwaV9pZGxlX2VudGVyX2JtKHByLCBjeCwgZmFsc2UpOw0KLQkJ
CXJldHVybjsNCisJCQlyZXR1cm4gMDsNCiAJCX0gZWxzZSB7DQogCQkJQUNQSV9GTFVTSF9DUFVf
Q0FDSEUoKTsNCiAJCX0NCi0tIA0KMS43LjkuNQ0K

