Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC72425913
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Oct 2021 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbhJGRQt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Oct 2021 13:16:49 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38461 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbhJGRQs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2021 13:16:48 -0400
Received: by mail-ot1-f43.google.com with SMTP id c6-20020a9d2786000000b005471981d559so8318495otb.5;
        Thu, 07 Oct 2021 10:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3T+99c1VzdeIyWusVw2Hmd834PbhCd+xwBC9PQfBAU=;
        b=ZSdMxaZUUsu/2DVEo4fdGV0vBrburiP7mq08sjd01dW2AMai793nS3YeIk6kg2uStf
         bb33C20t0X2adxOxvLs4OtvU26uaeccMEN/o3FUHS+92xvgklWf0GB38Qa0o+sLnK28Q
         XUdFZwgBtYmuqat/JN3PfcIkuhdxQ1787TTe5oLSzxnTQnkR2OliVW01EXyYnSaojELS
         VxKwIDjttHxoN2CL5FZOfr7MRQHwkUW/AZt25d01jwQMxwETQ6F29GSpzQDT9l+vY7BP
         r2gpxKCKTxhfju5ZTCqMW+0uEKJ6g2zIilxe29yBTxF0/z+oXIKK8JSeD2XlkcEcht/J
         AEVA==
X-Gm-Message-State: AOAM531DUv16wAL2t7urq0bhdZV1cpXLaek7xc6O6DY/G33VzFp/h6n5
        MTOU3eoz/guL9b68esyCrVKNTZLybFY0gPKdGws=
X-Google-Smtp-Source: ABdhPJzPyc5/odlg3KjW2vM3IxGJxxUY7A2LQ1173rtZ7uvV+MchTgq6oN7E52MCLQ63VXxcwWhf/yUYCdwcF3wla6I=
X-Received: by 2002:a9d:3783:: with SMTP id x3mr4690364otb.16.1633626894283;
 Thu, 07 Oct 2021 10:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211006113745.60186-1-sohaib.amhmd@gmail.com>
In-Reply-To: <20211006113745.60186-1-sohaib.amhmd@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 19:14:43 +0200
Message-ID: <CAJZ5v0jzmGWR82zfpGjd2K_YfvzS_ktVeq6oX-p=tx9OXjOTxA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: drop unneeded initialization value
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 6, 2021 at 1:37 PM Sohaib Mohamed <sohaib.amhmd@gmail.com> wrote:
>
> Do not initialise statics to 0
>
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
>  drivers/acpi/acpica/dbhistry.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
> index fd813c5d3952..60b77b11c0f2 100644
> --- a/drivers/acpi/acpica/dbhistry.c
> +++ b/drivers/acpi/acpica/dbhistry.c
> @@ -24,9 +24,9 @@ typedef struct history_info {
>  } HISTORY_INFO;
>
>  static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
> -static u16 acpi_gbl_lo_history = 0;
> -static u16 acpi_gbl_num_history = 0;
> -static u16 acpi_gbl_next_history_index = 0;
> +static u16 acpi_gbl_lo_history;
> +static u16 acpi_gbl_num_history;
> +static u16 acpi_gbl_next_history_index;
>
>  /*******************************************************************************
>   *
> --

Please submit ACPICA changes like this to the upstream ACPICA project
as per MAINTANIERS.

Thanks!
