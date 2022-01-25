Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06EF49AC70
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jan 2022 07:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbiAYGeI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jan 2022 01:34:08 -0500
Received: from box.aukejan.com ([173.82.79.94]:35359 "EHLO box.aukejan.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348616AbiAYGag (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jan 2022 01:30:36 -0500
Received: from authenticated-user (box.aukejan.com [173.82.79.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.aukejan.com (Postfix) with ESMTPSA id DE7F75D334;
        Mon, 24 Jan 2022 22:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=boldcoder.com;
        s=mail; t=1643092222;
        bh=kvafKXzjkn/Bnf3nCC3bA3bKGXSxh/H7lXD2LBSFypA=;
        h=Subject:References:To:From:Cc:Date:In-Reply-To:From;
        b=Sa28aqWv3BU/laUhoiXsb/ddDe2usBbgoeeQi3MYnJV9lQ6zdaYNHCOqoRx5lIxPY
         kcdxMEjwLZhvIeZ/fjez3x625eP9REC2qOK49BLw6MATUaQCQZ43AmFYxeDY/ovXne
         RCueyPCXhESbH5Zc1+wWL7czGipE9fdSOgUIUqlHKdFYZmYnXn4SR/yW6zDDMw0Wmo
         BSXIaFwyHUo0/jf450Ej5/Ha22QpNaK8XU1CwTDvZ/NPMkrVQ3hEWvLMWXU2d6JbpM
         DD3MPSGNOH0cpV5Vs1vg+72sPats+u1m1WGJbxgbJ7UhJCcRim93cFvlmovVSSDRMF
         +BPbpozAY5hwg==
Subject: Patch: Make ACPI subsystem provide CEDT table
References: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
From:   Robert Kiraly <me@boldcoder.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
X-Forwarded-Message-Id: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com>
Message-ID: <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com>
Date:   Mon, 24 Jan 2022 22:30:22 -0800
MIME-Version: 1.0
In-Reply-To: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a simple ACPI patch. I'm submitting a revised version to=20
linux-acpi per Rafael Wysocki and linux-cxl per Dan Williams.

The patch has been moved to the message body and a Signed-off-by tag has =

been added. Thunderbird has added CRs so "patch -p1 -l" is needed. To=20
address other points:

Q. Dan Williams said: Yes, although I don't see much incremental benefit =

to developers publishing a root only raw table... So, not opposed to the =

patch, but I want to direct you to the sysfs representation of the CEDT=20
and CFMWS in /sys/bus/cxl/devices... Platform firmware CXL details are=20
modeled as "CXL root" objects in the /sys/bus/cxl device model.

A. The patch is being submitted in connection with work on a CXL bridge. =

The developers would like to express appreciation for the "sysfs" point. =

They find it useful to be able to do initialization through the table=20
but will look at the "sysfs" approach.

Q. Rafael J. Wysocki said: I'm not sure why the #ifdef is needed.

A. I reviewed cxl-next and decided to add the #ifdef to ensure that the=20
code would compile regardless of the direction that the codebase takes.

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
@@ -500,6 +500,9 @@
  	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
  	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
  	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
+#ifdef ACPI_SIG_CEDT
+       ACPI_SIG_CEDT,
+#endif
  	ACPI_SIG_NHLT };

  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
=3D=3D=3D=3D end of patch =3D=3D=3D=3D


