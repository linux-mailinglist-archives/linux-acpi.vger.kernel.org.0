Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703394A9F6E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Feb 2022 19:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbiBDSqD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 4 Feb 2022 13:46:03 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:35607 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbiBDSqD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Feb 2022 13:46:03 -0500
Received: by mail-yb1-f170.google.com with SMTP id c19so21422469ybf.2;
        Fri, 04 Feb 2022 10:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hCUMOL6V3U58saOLiG9F6UunaXxXP2ihqyJDRgrcHDY=;
        b=8HuIBnvE2OHtc9Vwn9jxlwWQ7YMHFPrPfl9AXc6Gp4z4jbysJpgYkZMO2WAhK+wmk3
         DmLyyZTULrvdTv35hINd6MkSo7o2dw51ozw1z+e3HlCR6tgQLnQDW+1eEKi5ubJeo00v
         CoNgEFYcOYaCxL01A4doTBIMDK1vjWpRMX67RSpJAl4ji7gzjjM4ZhO+zJ8Vmf8eC7Hs
         1uuGBXwPT1kD3ho+xLptguH1CJFSU5JAjrbt2siulK4I+YHVSRyWxJsIMkYadt49OzPw
         OT6nShAoFvXH1RI5dsDyGyU6J+L6gS8R/vBmQpkJXlN5mlj+z2j4Xfrr15U4MVoL9PRX
         3JqA==
X-Gm-Message-State: AOAM530JZWdXjqGq495z687MNUKyLCi/0eoDvAdYursR0/V8v/fxxpnF
        psBDlF35gcYBWLfmE72bso5AmiiR5IsPONf+VQY=
X-Google-Smtp-Source: ABdhPJyo5iw50NuLJN/0r4j/TCTGBZF1CsqIqm+zpMJc1MFPsVmchM+OQcUDaEyE1Srv2iVdVtlJiZ6GBeMyabie4Ig=
X-Received: by 2002:a81:3744:: with SMTP id e65mr230927ywa.301.1644000362544;
 Fri, 04 Feb 2022 10:46:02 -0800 (PST)
MIME-Version: 1.0
References: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com>
 <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com> <a20337bb-9e83-e387-7d10-a2843f7286b3@boldcoder.com>
In-Reply-To: <a20337bb-9e83-e387-7d10-a2843f7286b3@boldcoder.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 19:45:51 +0100
Message-ID: <CAJZ5v0jNvvjRzXRA36nQve7KSFOqtkfLc-u3V8xNV+V+kzv4gg@mail.gmail.com>
Subject: Re: Patch: Make ACPI subsystem provide CEDT table
To:     Robert Kiraly <me@boldcoder.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 27, 2022 at 11:15 AM Robert Kiraly <me@boldcoder.com> wrote:
>
> This is a simple ACPI patch. I'm submitting a revised version to
> linux-acpi per Rafael Wysocki and linux-cxl per Dan Williams.
>
> Thunderbird has added CRs so "patch -p1 -l" is needed.
>
> ==== start of patch ====
> Subject: Make ACPI subsystem provide CEDT table
> Signed-off-by: Robert Kiraly <me@boldcoder.com>
>
> This is a simple patch to the ACPI subsystem. The patch adds ACPI
> _SIG_CEDT to table_sigs[] in  "drivers/acpi/tables.c".
>
> Presently,  CXL code isn't able to make use of the  CEDT table at
> the initrd stage. Subsequent to the change, the CEDT table can be
> used.
>
> If  a developer  plans to use the CEDT table to  program  the CXL
> ports,  this change is needed.  Otherwise,  it isn't  expected to
> make a difference.
>
> I certify  compliance with  Developer’s Certificate of Origin 1.1
> as listed in:
> https://www.kernel.org/doc/html/v4.10/process/submitting-patches.
> html
>
> --- linux-5.16.old/drivers/acpi/tables.c
> +++ linux-5.16/drivers/acpi/tables.c
> @@ -500,7 +500,7 @@
>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> -       ACPI_SIG_NHLT };
> +       ACPI_SIG_CEDT, ACPI_SIG_NHLT };
>
>   #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> ==== end of patch ====

I've queued up this change for 5.18, but I needed to rebase the patch
and I changed its subject and changelog.

Thanks!
