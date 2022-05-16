Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD6528C1C
	for <lists+linux-acpi@lfdr.de>; Mon, 16 May 2022 19:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiEPRhR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 May 2022 13:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiEPRhQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 May 2022 13:37:16 -0400
X-Greylist: delayed 687 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 May 2022 10:37:15 PDT
Received: from sender4-of-o58.zoho.com (sender4-of-o58.zoho.com [136.143.188.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE00FD3A
        for <linux-acpi@vger.kernel.org>; Mon, 16 May 2022 10:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652721941; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MQeFmKR3gB8XyOHY8gne52tEFmoHgBClx5oLclILgXAXjI8hwShXzbWOc+DInP1dvaBb/A6KYt4EZH3CV42i5MUcXSB6PO6taNIBIBRfCaEFR8QrKQy7cT+RnBWU06sSxYMbQutv36j3YlIMfrBc1akaz8NhQfYY9wf6y1BmcOI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1652721941; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=IKOeFlmUjA5Fjdk5mYV0getpP+8le9LGF7g8Udv0S1w=; 
        b=Ps6Qp5NAODhpdcB1XVSTyjoIxQXcTL7td3euPN9MpE0thbnQQCUnNtSCL6TlXqcn+wRq6rc9QEAnZPAA5zkIr+SnkTeEqUFk85J/+afNGII4SMMmp7nxxDkbyIkG8d1+D4hPFs+mz/mvX97bf05ov5U1/0zGCLB9ibOuSIQTqIc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de>
Received: from z3r0.lan (185.31.62.161 [185.31.62.161]) by mx.zohomail.com
        with SMTPS id 1652721940160127.3711236380924; Mon, 16 May 2022 10:25:40 -0700 (PDT)
Message-ID: <f80dfd57fdca87897f070a3ea4ee0a26b03e7831.camel@mniewoehner.de>
Subject: [PATCH] ACPI: utils: include UUID in _DSM evaluation warning
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 16 May 2022 19:25:37 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.42.2 
Content-Transfer-Encoding: base64
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VGhlIF9EU00gZXZhbHVhdGlvbiB3YXJuaW5nIGluIGl0cyBjdXJyZW50IGZvcm0gaXMgbm90IHZl
cnkgaGVscGZ1bCwgYXMgCml0IGxhY2tzIGFueSBzcGVjaWZpYyBpbmZvcm1hdGlvbjoKwqAgQUNQ
STogXDogZmFpbGVkIHRvIGV2YWx1YXRlIF9EU00gKDB4MTAwMSkKClRodXMsIGluY2x1ZGUgdGhl
IFVVSUQgb2YgdGhlIG1pc3NpbmcgX0RTTToKwqAgQUNQSTogXDogZmFpbGVkIHRvIGV2YWx1YXRl
IF9EU00gYmYwMjEyZjItLi4uICgweDEwMDEpCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIE5pZXfD
tmhuZXIgPGxpbnV4QG1uaWV3b2VobmVyLmRlPgotLS0KwqBkcml2ZXJzL2FjcGkvdXRpbHMuYyB8
IDMgKystCsKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS91dGlscy5jIGIvZHJpdmVycy9hY3BpL3V0aWxzLmMK
aW5kZXggZDVjZWRmZmVlZmY5Li43ZGE5OTNmNWI2YzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNw
aS91dGlscy5jCisrKyBiL2RyaXZlcnMvYWNwaS91dGlscy5jCkBAIC02ODEsNyArNjgxLDggQEAg
YWNwaV9ldmFsdWF0ZV9kc20oYWNwaV9oYW5kbGUgaGFuZGxlLCBjb25zdCBndWlkX3QgKmd1aWQs
CnU2NCByZXYsIHU2NCBmdW5jLArCoArCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCAhPSBBRV9OT1Rf
Rk9VTkQpCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWNwaV9oYW5kbGVfd2Fybiho
YW5kbGUsCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCJmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSAoMHgleClcbiIsIHJldCk7CivC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCJmYWlsZWQgdG8gZXZhbHVhdGUgX0RTTSAlcFViICgweCV4KVxuIiwKK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0LCBn
dWlkKTsKwqAKwqDCoMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOwrCoH0KLS0gCjIuMzQuMQoKCg==

