Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA236455D05
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 14:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhKRNzK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 08:55:10 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38631 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhKRNzK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 08:55:10 -0500
Received: by mail-ot1-f49.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so11056992otj.5
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 05:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCW1GxfLaraECmHY4/GdsXW0ef44K6+D4/RDFaZmzzU=;
        b=VCA4zy2D6GO6ed+BqYB95lQzRXVpSBfJz8BtC5MuPM1cdjFbSLLVnq9Ql6BZkug+e2
         ZXYlrlSPlWKnWR/+xcl670lu2xso5D2wjhsSW826B4enRj0U/7ehoCbcTpbTARj747xv
         jQnvGE7Bl5NZmCYf/fLBiyKy5Z7x7rjW8iokBQ9jjvqj71lg8YkSs8LpYLDpxu19cIW6
         0dQMBUrnlxFuQUtgG1KkMg3tWTscY7a9hglI1KIhvLbioy98ahpL8ue+QkqxCdt18uE2
         J/HE2NhxB4NGomKK5Mml+wF7ZWUrOkqDdvyJl6MHASRJb4L6Wiq7C6zz4oIom7+QGDQM
         Eyow==
X-Gm-Message-State: AOAM5314oHNSa74PxEx8q6KQcPfqGl6HtvIH5c30rG8E3urN8812TkUk
        ItqPI09e/GpIrC5e424qmUCCgZwrG4k1aXugBnM=
X-Google-Smtp-Source: ABdhPJx9M950kr7bHo7NRfLvZfVPd85Xg/Fmxx2za22cpFaXBNvGgDCpki0BiZADT4y6odx4sJeYt5CF/7oM3rn0NG0=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr21322402otu.254.1637243529899;
 Thu, 18 Nov 2021 05:52:09 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
 <CAJZ5v0hCYE7_eHtnfA3Vn1PFS=Dqk5=dwdbaD_k+nusJucFaCQ@mail.gmail.com>
 <CAA85sZuSGh9pQwvHio6NkNoahQjpjCxoPAhp3MOc-aGeWjDHXg@mail.gmail.com>
 <CAJZ5v0gvEbW9aVTp+yL22fbGrhX2h667g1kGE3phxEN03e_JtA@mail.gmail.com>
 <CAA85sZsFNoQfQo0ZR79Vzw4f-o7WaxgBQ_2RhyCBMxcNkmrCeg@mail.gmail.com> <CAA85sZs-mgx2UqJZ8LHqmwYFr6EoVs=rM-wnStT=T0b+q9pdVQ@mail.gmail.com>
In-Reply-To: <CAA85sZs-mgx2UqJZ8LHqmwYFr6EoVs=rM-wnStT=T0b+q9pdVQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 14:51:58 +0100
Message-ID: <CAJZ5v0gs8vCU+fiveOjg8DJ7ys1MD-KdDm1=gjf5k2+9Qi_F_A@mail.gmail.com>
Subject: Re: HP Elitebook 840 G5 - acpi failure
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000002e86805d1107701"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--00000000000002e86805d1107701
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 18, 2021 at 2:41 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> So, hard to capture, crashes faster with minimal output:
> https://photos.app.goo.gl/9p56395EdhNBuikQA
>
> First time i didn't even see the oops at all...

The dynamic debug output is still not present.

Please apply the attached patch (you may need to adjust it for 5.15 -
the idea is to comment out the execution of _ON and _OFF) and boot
with the dyndbg in power.c enabled.

It should not crash this time, so you should be able to collect full
dmesg and send it (as an attachment, please).

--00000000000002e86805d1107701
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-power-debug.patch"
Content-Disposition: attachment; filename="acpi-power-debug.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kw50epef0>
X-Attachment-Id: f_kw50epef0

LS0tCiBkcml2ZXJzL2FjcGkvcG93ZXIuYyB8ICAgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpJbmRl
eDogbGludXgtcG0vZHJpdmVycy9hY3BpL3Bvd2VyLmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0u
b3JpZy9kcml2ZXJzL2FjcGkvcG93ZXIuYworKysgbGludXgtcG0vZHJpdmVycy9hY3BpL3Bvd2Vy
LmMKQEAgLTM2MiwxMyArMzYyLDEzIEBAIHN0YXRpYyBpbnQgX19hY3BpX3Bvd2VyX29uKHN0cnVj
dCBhY3BpX3AKIHsKIAlhY3BpX2hhbmRsZSBoYW5kbGUgPSByZXNvdXJjZS0+ZGV2aWNlLmhhbmRs
ZTsKIAlzdHJ1Y3QgYWNwaV9wb3dlcl9kZXBlbmRlbnRfZGV2aWNlICpkZXA7Ci0JYWNwaV9zdGF0
dXMgc3RhdHVzID0gQUVfT0s7CisJLy9hY3BpX3N0YXR1cyBzdGF0dXMgPSBBRV9PSzsKIAotCXN0
YXR1cyA9IGFjcGlfZXZhbHVhdGVfb2JqZWN0KGhhbmRsZSwgIl9PTiIsIE5VTEwsIE5VTEwpOwot
CWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgewotCQlyZXNvdXJjZS0+c3RhdGUgPSBBQ1BJX1BP
V0VSX1JFU09VUkNFX1NUQVRFX1VOS05PV047Ci0JCXJldHVybiAtRU5PREVWOwotCX0KKwkvL3N0
YXR1cyA9IGFjcGlfZXZhbHVhdGVfb2JqZWN0KGhhbmRsZSwgIl9PTiIsIE5VTEwsIE5VTEwpOwor
CS8vaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7CisJLy8JcmVzb3VyY2UtPnN0YXRlID0gQUNQ
SV9QT1dFUl9SRVNPVVJDRV9TVEFURV9VTktOT1dOOworCS8vCXJldHVybiAtRU5PREVWOworCS8v
fQogCiAJcmVzb3VyY2UtPnN0YXRlID0gQUNQSV9QT1dFUl9SRVNPVVJDRV9TVEFURV9PTjsKIApA
QCAtNDIwLDEzICs0MjAsMTMgQEAgc3RhdGljIGludCBhY3BpX3Bvd2VyX29uKHN0cnVjdCBhY3Bp
X3Bvdwogc3RhdGljIGludCBfX2FjcGlfcG93ZXJfb2ZmKHN0cnVjdCBhY3BpX3Bvd2VyX3Jlc291
cmNlICpyZXNvdXJjZSkKIHsKIAlhY3BpX2hhbmRsZSBoYW5kbGUgPSByZXNvdXJjZS0+ZGV2aWNl
LmhhbmRsZTsKLQlhY3BpX3N0YXR1cyBzdGF0dXM7CisJLy9hY3BpX3N0YXR1cyBzdGF0dXM7CiAK
LQlzdGF0dXMgPSBhY3BpX2V2YWx1YXRlX29iamVjdChoYW5kbGUsICJfT0ZGIiwgTlVMTCwgTlVM
TCk7Ci0JaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7Ci0JCXJlc291cmNlLT5zdGF0ZSA9IEFD
UElfUE9XRVJfUkVTT1VSQ0VfU1RBVEVfVU5LTk9XTjsKLQkJcmV0dXJuIC1FTk9ERVY7Ci0JfQor
CS8vc3RhdHVzID0gYWNwaV9ldmFsdWF0ZV9vYmplY3QoaGFuZGxlLCAiX09GRiIsIE5VTEwsIE5V
TEwpOworCS8vaWYgKEFDUElfRkFJTFVSRShzdGF0dXMpKSB7CisJLy8JcmVzb3VyY2UtPnN0YXRl
ID0gQUNQSV9QT1dFUl9SRVNPVVJDRV9TVEFURV9VTktOT1dOOworCS8vCXJldHVybiAtRU5PREVW
OworCS8vfQogCiAJcmVzb3VyY2UtPnN0YXRlID0gQUNQSV9QT1dFUl9SRVNPVVJDRV9TVEFURV9P
RkY7CiAK
--00000000000002e86805d1107701--
