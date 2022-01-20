Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9335495465
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jan 2022 19:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbiATStM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jan 2022 13:49:12 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:40957 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiATStL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jan 2022 13:49:11 -0500
Received: by mail-qk1-f178.google.com with SMTP id z10so7084170qkf.7
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jan 2022 10:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jaRIDGe9KDU68uccINc/QzE2gGMw7r9ZutPhxtnBTQk=;
        b=u7zUFMAUgufVlBKBEi7WEZhG1zOuJifEtKRTr/PDjeWpL43nfYFTojjbBBHCRNDHdC
         Pd4nDWFgODv91d3b8E/Za5DRvc4nDBLB5VAKxq3K7P7Zdq/vK/QJkWCOEg0Ds5jp8Cnp
         RvVPTJ0ZxNE8EJLH73LmAUWSqqxfWdgJxB8CRJbcA2cDOfvOMnPTOc9xb7zG415wlyfF
         Vl8xETdQUIUfeX79xZLRzjP04vzUdqDW0AE60b5YQYk3cdh4MHj7NVIYOJZD3gvAWDZm
         vM8lFSrP8ddIhVQzwXtZdEgosSE8FFM0S2LKYbzY9cB+9JsDPoyMbvQnoR5J8QZC/ARZ
         jVOw==
X-Gm-Message-State: AOAM531N6aLF8XH/XjeGRIjMnOezKKEfuibZ+RQv0BFN4fiWK6wmoyF5
        w2xZAbgnxz6ZFPS2rEOcDDuv71zT1ESS5pXtrtI=
X-Google-Smtp-Source: ABdhPJx8/mORd9661w3sYmvTYCulda5kT6ujAnWoRfP1+DXHbgQ9bi97qzqGUwDZunOFsz4i5+B0S+DXzZTEHgvXQw0=
X-Received: by 2002:a37:dc45:: with SMTP id v66mr152235qki.516.1642704551106;
 Thu, 20 Jan 2022 10:49:11 -0800 (PST)
MIME-Version: 1.0
References: <198c0ae2-efdf-7f47-11c7-27e9a87b3f32@boldcoder.com>
In-Reply-To: <198c0ae2-efdf-7f47-11c7-27e9a87b3f32@boldcoder.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jan 2022 19:49:00 +0100
Message-ID: <CAJZ5v0ghyNEZayq6CsRpP3LDjFRrCsuSUacU99s8U1Bj6x1o9A@mail.gmail.com>
Subject: Re: Patch: Make ACPI subsystem provide CEDT table
To:     Robert Kiraly <me@boldcoder.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 13, 2022 at 12:16 AM Robert Kiraly <me@boldcoder.com> wrote:
>
> This is a simple ACPI patch. I'm submitting a revised version to
> linux-acpi as opposed to linux-pm at Rafael Wysocki's suggestion.
>
> The patch adds ACPI_SIG_CEDT to table_sigs[] in "drivers/acpi/tables.c".

This can be done, but please send a patch in the message body (not as
an attachment) and provide a Signed-off-by tag for it.

Also I'm not sure why the #ifdef is needed.
