Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D652E49DEF4
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jan 2022 11:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiA0KPX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jan 2022 05:15:23 -0500
Received: from box.aukejan.com ([173.82.79.94]:41535 "EHLO box.aukejan.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238913AbiA0KPX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jan 2022 05:15:23 -0500
Received: from authenticated-user (box.aukejan.com [173.82.79.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.aukejan.com (Postfix) with ESMTPSA id E207B5D244;
        Thu, 27 Jan 2022 02:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=boldcoder.com;
        s=mail; t=1643278522;
        bh=ZdKc9q4aIMBMcoe62PEfHd193UcT39U+kgm3F2x+ues=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=OcUDpf/zonOAhWMQzzfOt0MBka/zueJNNhkyQ4uLLYNZKGhJwsOZrRpOoF3TxFVCL
         xwn2h3t4z7lhM6SQSOmNY9hfnGMKYj98lMLD+mTji00Bn08H3R9IbWr/N9Cpof5vca
         +c+rf5+kRmNzrUmWOi5/r3mv9xPzmwYQmea/wF9NTp8C++HFefe32Zgd+DjGqhayGC
         +VuPVdUVxkw7azWHo9J1xtd1DsUICczQvGnpNy/5ynlGC4c1yPBrpMbmsTfiz/y6b1
         9DXLa6HBTrV1QjRx3c99W5hc2g7GjfBKGl5ml0LNhaErTghVNp+Ts2gh5nlgmpmQbo
         BfItEKmF04l1w==
Subject: Patch: Make ACPI subsystem provide CEDT table
From:   Robert Kiraly <me@boldcoder.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com>
 <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com>
Message-ID: <a20337bb-9e83-e387-7d10-a2843f7286b3@boldcoder.com>
Date:   Thu, 27 Jan 2022 02:15:23 -0800
MIME-Version: 1.0
In-Reply-To: <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a simple ACPI patch. I'm submitting a revised version to=20
linux-acpi per Rafael Wysocki and linux-cxl per Dan Williams.

Thunderbird has added CRs so "patch -p1 -l" is needed.

=3D=3D=3D=3D start of patch =3D=3D=3D=3D
Subject: Make ACPI subsystem provide CEDT table
Signed-off-by: Robert Kiraly <me@boldcoder.com>

This is a simple patch to the ACPI subsystem. The patch adds ACPI
_SIG_CEDT to table_sigs[] in  "drivers/acpi/tables.c".

Presently,  CXL code isn't able to make use of the  CEDT table at
the initrd stage. Subsequent to the change, the CEDT table can be
used.

If  a developer  plans to use the CEDT table to  program  the CXL
ports,  this change is needed.  Otherwise,  it isn't  expected to
make a difference.

I certify  compliance with  Developer=E2=80=99s Certificate of Origin 1.1=

as listed in:
https://www.kernel.org/doc/html/v4.10/process/submitting-patches.
html

--- linux-5.16.old/drivers/acpi/tables.c
+++ linux-5.16/drivers/acpi/tables.c
@@ -500,7 +500,7 @@
  	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT };
+	ACPI_SIG_CEDT, ACPI_SIG_NHLT };

  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)

=3D=3D=3D=3D end of patch =3D=3D=3D=3D

