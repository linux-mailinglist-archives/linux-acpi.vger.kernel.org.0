Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB943B531
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2019 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390004AbfFJMpx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Jun 2019 08:45:53 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:35778 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389606AbfFJMpx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jun 2019 08:45:53 -0400
Received: by mail-it1-f172.google.com with SMTP id n189so12888690itd.0
        for <linux-acpi@vger.kernel.org>; Mon, 10 Jun 2019 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VlfIrRpW9Pw2iNOC0bzxZ12Wt2dKPjEcNdXBG3DPHm0=;
        b=Ql8Fboy08ennCJL2/HZ/aMq+PqpHR9Vp6yCVVXkRlclvENGtpx02Apf6UirIRU5WAQ
         OVQZbNHrD/NHXJKybG1eAjj/Oh8q/19yazOhXg+4PF1baSpqNIwiRcu/WpmIYb7N5kF+
         +4TNXHlnAhUtXsPdzbc+m3WjYDWYV/Zg7/ZX2FHcTBut5DRqZVJo5E+FsjkpToWh+j49
         hnd+NDJkHSDWMxRiEBeJ8gKbMIVOk6o6THCOlsgvNuxFAO8FeCwgkj1lfu8iXqgCGOFW
         A2Fph94lzINKFJ+LUmrBpa2fSQBrcYZFOx5gz44Eh9wW4FbcjStGWl4U+M1wFaG+6ELI
         S92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VlfIrRpW9Pw2iNOC0bzxZ12Wt2dKPjEcNdXBG3DPHm0=;
        b=c5M92jHK6x0sgTe+bw4g0xWif0/36bpJAqmbNUtvC8sYEuGbnNkSh/1NrPwWLiZ5tT
         WIPzAWK9I+1vt3IG2K0WMNuIfcNNu28RYcSAX2hVQ78jZqBcn3RnFCC8PQ15Xo3Besdj
         N7CoQfkSKbjcom4QsBMO16U0iJgamifgfkTqT6CQgifrhHGcNlu77FmE8ae3gnG6CsT5
         p77RXd+AJDJhaXxjgnHhsav/hrudkxFCQU1dgtEBfKnZsfSZpKl1aoVF/50tEjRkCD4X
         JZbl2RbeEm/ps7NOWcB+yGF2DHx0AIacvxUCeiXoo8qFovFsGeP9BaIEVcf7o7vlDrRJ
         1apw==
X-Gm-Message-State: APjAAAX+tMnCFfg3mZNA3ZjG0f2uXELJ+DMUu2e5GMxYuwp69SSkgNd9
        u9Swrl55JMVbcM26aUnWMrvUus1W0Hz8PbahkG+wHka/Dc8=
X-Google-Smtp-Source: APXvYqzQU4GRfGn5jgzlDoKQRVCfG042JPOQLo2IDl/fdlE2G1o/Ekc2IROX3IxtF73EqF/IU7HlZO6ECp9WTI0NzNw=
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr33535027jai.39.1560170752467;
 Mon, 10 Jun 2019 05:45:52 -0700 (PDT)
MIME-Version: 1.0
From:   Andrea Oliveri <oliveriandrea@gmail.com>
Date:   Mon, 10 Jun 2019 14:45:41 +0200
Message-ID: <CAN2kSaqhq1QfCQ1kM-tLr8Q0ptFQcdujgnQW-xYZKAzi_-pHAw@mail.gmail.com>
Subject: [PATCH] ACPI: BGRT table overriding
To:     linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net
Content-Type: multipart/mixed; boundary="0000000000007d8d9c058af78ff3"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--0000000000007d8d9c058af78ff3
Content-Type: text/plain; charset="UTF-8"

Thinkpad T Series expose a malformed BGRT table with Version field set
to 0. This fact prevents bootsplashes (as Plymouth) to correctly show
the manufacturer logo. This patch permits to override malformed BGRT
table with a correct one defined by the user.

--0000000000007d8d9c058af78ff3
Content-Type: text/x-patch; charset="US-ASCII"; name="bgrt_override.patch"
Content-Disposition: attachment; filename="bgrt_override.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jwqd8ffo0>
X-Attachment-Id: f_jwqd8ffo0

U2lnbmVkLW9mZi1ieTogQW5kcmVhIE9saXZlcmkgPG9saXZlcmlhbmRyZWFAZ21haWwuY29tPgoK
LS0tIGEvZHJpdmVycy9hY3BpL3RhYmxlcy5jCTIwMTktMDYtMTAgMTM6MzY6MzUuMjk3MTQ1NzQ4
ICswMjAwCisrKyBiL2RyaXZlcnMvYWNwaS90YWJsZXMuYwkyMDE5LTA2LTEwIDEzOjQ5OjQ1Ljk4
OTgwMjEzNyArMDIwMApAQCAtNDkwLDE2ICs0OTAsMTcgQEAgc3RhdGljIHU4IF9faW5pdCBhY3Bp
X3RhYmxlX2NoZWNrc3VtKHU4CiAKIC8qIEFsbCBidXQgQUNQSV9TSUdfUlNEUCBhbmQgQUNQSV9T
SUdfRkFDUzogKi8KIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdGFibGVfc2lnc1tdID0gewot
CUFDUElfU0lHX0JFUlQsIEFDUElfU0lHX0NQRVAsIEFDUElfU0lHX0VDRFQsIEFDUElfU0lHX0VJ
TkosCi0JQUNQSV9TSUdfRVJTVCwgQUNQSV9TSUdfSEVTVCwgQUNQSV9TSUdfTUFEVCwgQUNQSV9T
SUdfTVNDVCwKLQlBQ1BJX1NJR19TQlNULCBBQ1BJX1NJR19TTElULCBBQ1BJX1NJR19TUkFULCBB
Q1BJX1NJR19BU0YsCi0JQUNQSV9TSUdfQk9PVCwgQUNQSV9TSUdfREJHUCwgQUNQSV9TSUdfRE1B
UiwgQUNQSV9TSUdfSFBFVCwKLQlBQ1BJX1NJR19JQkZULCBBQ1BJX1NJR19JVlJTLCBBQ1BJX1NJ
R19NQ0ZHLCBBQ1BJX1NJR19NQ0hJLAotCUFDUElfU0lHX1NMSUMsIEFDUElfU0lHX1NQQ1IsIEFD
UElfU0lHX1NQTUksIEFDUElfU0lHX1RDUEEsCi0JQUNQSV9TSUdfVUVGSSwgQUNQSV9TSUdfV0FF
VCwgQUNQSV9TSUdfV0RBVCwgQUNQSV9TSUdfV0REVCwKLQlBQ1BJX1NJR19XRFJULCBBQ1BJX1NJ
R19EU0RULCBBQ1BJX1NJR19GQURULCBBQ1BJX1NJR19QU0RULAotCUFDUElfU0lHX1JTRFQsIEFD
UElfU0lHX1hTRFQsIEFDUElfU0lHX1NTRFQsIEFDUElfU0lHX0lPUlQsCi0JQUNQSV9TSUdfTkZJ
VCwgQUNQSV9TSUdfSE1BVCwgQUNQSV9TSUdfUFBUVCwgTlVMTCB9OworCUFDUElfU0lHX0JFUlQs
IEFDUElfU0lHX0JHUlQsIEFDUElfU0lHX0NQRVAsIEFDUElfU0lHX0VDRFQsCisJQUNQSV9TSUdf
RUlOSiwgQUNQSV9TSUdfRVJTVCwgQUNQSV9TSUdfSEVTVCwgQUNQSV9TSUdfTUFEVCwKKwlBQ1BJ
X1NJR19NU0NULCBBQ1BJX1NJR19TQlNULCBBQ1BJX1NJR19TTElULCBBQ1BJX1NJR19TUkFULAor
CUFDUElfU0lHX0FTRiwgIEFDUElfU0lHX0JPT1QsIEFDUElfU0lHX0RCR1AsIEFDUElfU0lHX0RN
QVIsCisJQUNQSV9TSUdfSFBFVCwgQUNQSV9TSUdfSUJGVCwgQUNQSV9TSUdfSVZSUywgQUNQSV9T
SUdfTUNGRywKKwlBQ1BJX1NJR19NQ0hJLCBBQ1BJX1NJR19TTElDLCBBQ1BJX1NJR19TUENSLCBB
Q1BJX1NJR19TUE1JLAorCUFDUElfU0lHX1RDUEEsIEFDUElfU0lHX1VFRkksIEFDUElfU0lHX1dB
RVQsIEFDUElfU0lHX1dEQVQsCisJQUNQSV9TSUdfV0REVCwgQUNQSV9TSUdfV0RSVCwgQUNQSV9T
SUdfRFNEVCwgQUNQSV9TSUdfRkFEVCwKKwlBQ1BJX1NJR19QU0RULCBBQ1BJX1NJR19SU0RULCBB
Q1BJX1NJR19YU0RULCBBQ1BJX1NJR19TU0RULAorCUFDUElfU0lHX0lPUlQsIEFDUElfU0lHX05G
SVQsIEFDUElfU0lHX0hNQVQsIEFDUElfU0lHX1BQVFQsCisJTlVMTCB9OwogCiAjZGVmaW5lIEFD
UElfSEVBREVSX1NJWkUgc2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlcikKIAo=
--0000000000007d8d9c058af78ff3--
