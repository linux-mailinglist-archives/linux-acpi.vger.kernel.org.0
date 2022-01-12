Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF7248CF05
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jan 2022 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiALXQQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jan 2022 18:16:16 -0500
Received: from box.aukejan.com ([173.82.79.94]:40801 "EHLO box.aukejan.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235235AbiALXQO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jan 2022 18:16:14 -0500
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 18:16:14 EST
Received: from authenticated-user (box.aukejan.com [173.82.79.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.aukejan.com (Postfix) with ESMTPSA id 2829B5D02B;
        Wed, 12 Jan 2022 15:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=boldcoder.com;
        s=mail; t=1642028848;
        bh=W2fRJ5DRD0yoAXsdwyCIRoTaNrMa4vko3jgoFM5Xk3Y=;
        h=From:To:Subject:Date:From;
        b=g3xbiz3DiwpwapG6XQxBmKaXpk8oFlLk0tK9LEM0mNoIi/b3WG3wjoSPmCfmCK36H
         BSThBcEXoTmAgfgaF0O7NvQqu2RF4VhvDJpKqqRZda/2xnp24XdzgbW9MeM3IklE4I
         LYPWXFi++taUEm2e3Mc4HDN+3K5YRmWVDQex1FJmKeKCRdBVwXd9Fq/U3gg5Q7JJz3
         wPVRlKMJta0Y1Vj7iIQUbdyCqKVqZwVk6BjR8vOsDufqHHZlZp1uwxL8j6GxIqVBrX
         gS3hxmt7dkg9vakdOmnRA09Q+ykvn0R+Tyb6c7pp6Eyxf5+vIGF1p+QkBWLXu6tUYi
         oI+M3Ak/i9Pvg==
From:   Robert Kiraly <me@boldcoder.com>
To:     linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Patch: Make ACPI subsystem provide CEDT table
Message-ID: <198c0ae2-efdf-7f47-11c7-27e9a87b3f32@boldcoder.com>
Date:   Wed, 12 Jan 2022 15:07:29 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------EF5DB6B94C4F883F0EC74C3E"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------EF5DB6B94C4F883F0EC74C3E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

This is a simple ACPI patch. I'm submitting a revised version to 
linux-acpi as opposed to linux-pm at Rafael Wysocki's suggestion.

The patch adds ACPI_SIG_CEDT to table_sigs[] in "drivers/acpi/tables.c".

The change will probably be made by upstream later regardless. But I've 
reviewed cxl-next and it doesn't seem to be present there yet.

Presently, CXL code isn't able to make use of the CEDT table. Subsequent 
to the change, the CEDT table can be used.

If a developer plans to use the CEDT table to program the CXL ports, 
this change is needed. Otherwise, it isn't expected to make a difference.

--------------EF5DB6B94C4F883F0EC74C3E
Content-Type: text/plain; charset=UTF-8;
 name="220112-cedt-patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="220112-cedt-patch.txt"

U3ViamVjdDogTWFrZSBBQ1BJIHN1YnN5c3RlbSBwcm92aWRlIENFRFQgdGFibGUKQXV0aG9y
OiBSb2JlcnQgS2lyYWx5IDxtZUBib2xkY29kZXIuY29tPgoKVGhpcyBpcyBhIHNpbXBsZSBw
YXRjaCB0byB0aGUgQUNQSSBzdWJzeXN0ZW0uCgpUaGUgcGF0Y2ggIGFkZHMgIEFDUElfU0lH
X0NFRFQgdG8gdGFibGVfc2lnc1tdIGluICAiZHJpdmVycy9hY3BpLwp0YWJsZXMuYyIuCgpQ
cmVzZW50bHksIENYTCAgY29kZSAgaXNuJ3QgYWJsZSB0byBtYWtlIHVzZSBvZiB0aGUgIENF
RFQgIHRhYmxlLgpTdWJzZXF1ZW50IHRvIHRoZSBjaGFuZ2UsIHRoZSBDRURUIHRhYmxlIGNh
biBiZSB1c2VkLgoKSWYgIGEgZGV2ZWxvcGVyICBwbGFucyB0byB1c2UgdGhlIENFRFQgdGFi
bGUgdG8gIHByb2dyYW0gIHRoZSBDWEwKcG9ydHMsICB0aGlzIGNoYW5nZSBpcyBuZWVkZWQu
ICBPdGhlcndpc2UsICBpdCBpc24ndCAgZXhwZWN0ZWQgdG8KbWFrZSBhIGRpZmZlcmVuY2Uu
CgotLS0gbGludXgtNS4xNi5vbGQvZHJpdmVycy9hY3BpL3RhYmxlcy5jCisrKyBsaW51eC01
LjE2L2RyaXZlcnMvYWNwaS90YWJsZXMuYwpAQCAtNTAwLDYgKzUwMCw5IEBACiAJQUNQSV9T
SUdfV0REVCwgQUNQSV9TSUdfV0RSVCwgQUNQSV9TSUdfRFNEVCwgQUNQSV9TSUdfRkFEVCwK
IAlBQ1BJX1NJR19QU0RULCBBQ1BJX1NJR19SU0RULCBBQ1BJX1NJR19YU0RULCBBQ1BJX1NJ
R19TU0RULAogCUFDUElfU0lHX0lPUlQsIEFDUElfU0lHX05GSVQsIEFDUElfU0lHX0hNQVQs
IEFDUElfU0lHX1BQVFQsCisjaWZkZWYgQUNQSV9TSUdfQ0VEVAorICAgICAgIEFDUElfU0lH
X0NFRFQsCisjZW5kaWYKIAlBQ1BJX1NJR19OSExUIH07CiAKICNkZWZpbmUgQUNQSV9IRUFE
RVJfU0laRSBzaXplb2Yoc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyKQo9PT09IGVuZCBvZiBw
YXRjaCA9PT09Cg==
--------------EF5DB6B94C4F883F0EC74C3E--
