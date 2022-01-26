Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1834A49CF02
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jan 2022 16:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiAZPzj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jan 2022 10:55:39 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:33752 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiAZPzj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jan 2022 10:55:39 -0500
Received: by mail-yb1-f175.google.com with SMTP id l68so303865ybl.0;
        Wed, 26 Jan 2022 07:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tS/hU9a6qKbfRs6o4tBwBgMOHHqiA1hfrv/AMjRdAAk=;
        b=Y3Yyt2qk6ntPjm1gzZPBx71wbqs0nW/K8Nu1Jzsyv0MY6Fi4jZY35bgDB/ulSXkaHe
         DR0jUolxT4iMDD7YdJGZZ0r8IgCSV9XwAE0pUJNjKxbBceN8u8Cjjs36Q+v+pC6eFuod
         QtfTcCGRDScosLdqRdjQFvO2Husz3ofGlilILvJJumEIFMYvluXQsRVqLxeZ8ZYqcq/4
         NFRq7OytGluygww4XKtLbENiz+7ZdkcqvJD0buARHC/URdoNX2PjUQEY6SB/ugv2MbJL
         xGbGBHV76Y2ZttqItwCme8m9oDqrmelJ7sY2lf+LAwIJlQVby8guvBdzMTQU14HsO+On
         q2JA==
X-Gm-Message-State: AOAM533vdrbM6+2MWWmhrj7zMYNzsH72RvJ71DsXN5rnTYmHMBnuiKRy
        /eEjZ3Gc2SK0GVQ0bU1KOz1Y+W6rHz0AlxHpLDA=
X-Google-Smtp-Source: ABdhPJwlkaUgZUT74WOhSFXXyQ/PLIOJUJ6EWYLi+FYjEnbTFILheuGkr+lNCQrHGqWx8kGwJbD4dDdydO/9DnnKDXE=
X-Received: by 2002:a5b:58d:: with SMTP id l13mr38206370ybp.475.1643212538736;
 Wed, 26 Jan 2022 07:55:38 -0800 (PST)
MIME-Version: 1.0
References: <1b871357-2231-336d-099c-cdccae03f837@boldcoder.com>
 <82f254a1-c765-0a87-f017-8c07c8ef07cd@boldcoder.com> <CAJZ5v0hRgzGm=axigeW9aPw+ai5hMCy975=vgdY4dGYZFzzMTA@mail.gmail.com>
 <46ce952d-e854-876d-26d4-b955064743f7@boldcoder.com>
In-Reply-To: <46ce952d-e854-876d-26d4-b955064743f7@boldcoder.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jan 2022 16:55:27 +0100
Message-ID: <CAJZ5v0hmv7HsLUZFJwNYBAWU=Dz_Yzz6nPj7esk4TQBSQ-h2DQ@mail.gmail.com>
Subject: Re: Patch: Make ACPI subsystem provide CEDT table
To:     Robert Kiraly <me@boldcoder.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 26, 2022 at 4:12 AM Robert Kiraly <me@boldcoder.com> wrote:
>
> On 01/25/2022 06:49AM, Rafael J. Wysocki wrote:
>  >
>  > ACPI_SIG_CEDT is defined in 5.17-rc1 AFAICS, so the #ifdef is redundant.
>
> Noted. Thank you. Should I resubmit without the #ifdef or if the patch
> is accepted can it be removed by upstream?

Please resubmit it without the #ifdef.
