Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43932FA40E
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393149AbhARPE4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 10:04:56 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43907 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405383AbhARPEV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2021 10:04:21 -0500
Received: by mail-oi1-f175.google.com with SMTP id q25so17945921oij.10
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2021 07:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaaMIalrFYwhzB1x2X5ejUsVgqoKBQE3WCNvHl3NOaY=;
        b=uAYKh4nYFQBZeKfhm8ZT1BX2EZs0GXVAMPC7C6cvU3w4kl5JAXGl+k1cckpzeiqmhp
         TNSGHkRGJqW0cMK3B5T0AcHh8eQQGnlfvuXTTcVwX38Mi8t+0OzkJL5nTSUeCvRfTnap
         FueqlHHfruepiraY9gdkirDscEdDcc9oaM9/dJ8kQFKC8WveBq1x7G3HDUXU79xXjO6/
         4HKwV1vAGzHRlJws+gWDKVTNcRgWawsuf5RjwrPi1RhYNF5aPwnA1PR0VcVyu8nlrR3Y
         zR6naL8hIsYh83dAaJ9uIFJtmlwpVDlz6Thr7WACT96dqNvTHKkSCHY60hEqOgknKs/W
         qlWg==
X-Gm-Message-State: AOAM532B0kIZIJQLV7zGZEt00am5LlhOICFnZCwJ7TMj5pPXH/44HPQQ
        EKB+wTVRGn93RuIHyM4rBHG+jJ9ri+t8iZvMqEK0VPPk
X-Google-Smtp-Source: ABdhPJzxCc/ebiaUGRJfSIvBQ38msRGmDYKk4sOfrIf33+mH415MyNWlCzRuY7fPETxfLFyZ1E/D0VDCpkTPRar3bLg=
X-Received: by 2002:aca:4892:: with SMTP id v140mr13408534oia.71.1610982219487;
 Mon, 18 Jan 2021 07:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20210115184826.2250-1-erik.kaneda@intel.com>
In-Reply-To: <20210115184826.2250-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jan 2021 16:03:23 +0100
Message-ID: <CAJZ5v0ht1z_TOaUNLxHRCAqG=FicvFUzwNwNvzdbZtQdxo-Fog@mail.gmail.com>
Subject: Re: [PATCH 0/9] ACPICA release 20201217 and 20210105
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 15, 2021 at 8:20 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This series contains ACPICA versions 20201217 and 20210105. These
> releases are quite small and contain trivial or stylistic fixes as well
> as deprecating MTMR and VRTC tables. The copyright update patch is large
> in size so it might not come through the mailing list. As an
> alternative, this patch set is hosted at the following link on github:
>
> https://github.com/SchmErik/linux/tree/20210105
>
> Al Stone (2):
>   ACPICA: Remove the MTMR (Mid-Timer) table
>   ACPICA: Remove the VRTC table
>
> Bob Moore (4):
>   ACPICA: add type casts for string functions
>   ACPICA: Update version to 20201217 Version 20201217.
>   ACPICA: Updated all copyrights to 2021
>   ACPICA: Update version to 20210105
>
> Maximilian Luz (2):
>   ACPICA: Fix exception code class checks
>   ACPICA: Clean up exception code class checks
>
> Nick Desaulniers (1):
>   ACPICA: ACPICA: fix -Wfallthrough

All patches in the series applied with some changelog adjustments, thanks!
