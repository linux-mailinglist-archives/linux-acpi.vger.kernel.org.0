Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773DF3A6980
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhFNPF2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 11:05:28 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:33534 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFNPF2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 11:05:28 -0400
Received: by mail-ot1-f44.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so11149718otl.0;
        Mon, 14 Jun 2021 08:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPbYMcbVjJFWR65dIngP8E9l9yv1eYtUSpLAZBQAiGE=;
        b=JI2pWFu8vuXqYrS5MEVNrJfwWBREkOBYPYmmTn5GGkpOvOEv8IPdfoBJ90lh/xvxxT
         z8FZrw4+TUDCtW18yW4FafIiqgY1mdqRTGzoAXiVpObQxoHCTYfSp/GyxvJ6+hv8wglM
         QnWr38PnFiXFYsmCYHMVUF/nBEAmCSBkFxhgzn3JN6OT1mu4RV7XRjX+QOUB6i8OTKLY
         qtrl2lQsGbJ4LGg1N4VZY3hzY81wwONANCMswwzojV/ICiY08IQbCGAl0A6hNo16rMxu
         JcQt1Ehl06WsaWAuSE0WgJ/+0mEwIXt7YvmTDhZOmrWgNauMXZ5A91QNnnDmEnSAtazV
         RBeQ==
X-Gm-Message-State: AOAM532iwwRSkfOs3kx0S2F3yUjm/Dpl/Ky3IhG/exlceB8HRBIubMK5
        G76DwaJnVbOJSsYue3xvOIxytOD6LEXXLPpfdkMNZVEe
X-Google-Smtp-Source: ABdhPJx3ouKCmYIbDp2yAp+zCPOGsXosGoyuHXKH7HI4h/1a3kmDUMFJK00QteD8JEQPCBmB7+gE1yNouu6XO//cJ4Y=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr14214484otb.206.1623682991631;
 Mon, 14 Jun 2021 08:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210610074812.57973-1-chenxiaosong2@huawei.com>
In-Reply-To: <20210610074812.57973-1-chenxiaosong2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jun 2021 17:03:00 +0200
Message-ID: <CAJZ5v0j6S4DxuNiN_VeZQ1hc8kAMJ4oz7-P=PmR4OnsN0PEURw@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: fix doc warnings
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yu kuai <yukuai3@huawei.com>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 10, 2021 at 9:41 AM ChenXiaoSong <chenxiaosong2@huawei.com> wrote:
>
> Fix gcc W=1 warnings:
> drivers/acpi/cppc_acpi.c:1356: warning: Function parameter or member 'cpu_num' not described in 'cppc_get_transition_latency'
> drivers/acpi/cppc_acpi.c:573: warning: Function parameter or member 'pcc_ss_id' not described in 'pcc_data_alloc'
> drivers/acpi/dock.c:388: warning: Function parameter or member 'ds' not described in 'handle_eject_request'
> drivers/acpi/dock.c:388: warning: Function parameter or member 'event' not described in 'handle_eject_request'
> drivers/acpi/sleep.c:496: warning: Function parameter or member 'acpi_state' not described in 'acpi_pm_start'
> drivers/acpi/sleep.c:536: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin'
> drivers/acpi/sleep.c:663: warning: Function parameter or member 'pm_state' not described in 'acpi_suspend_begin_old'
> drivers/acpi/sleep.c:956: warning: Function parameter or member 'stage' not described in 'acpi_hibernation_begin_old'
>
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 ++
>  drivers/acpi/dock.c      | 2 ++
>  drivers/acpi/sleep.c     | 4 ++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a4d4eebba1da..611938f2c132 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -561,6 +561,7 @@ bool __weak cpc_ffh_supported(void)
>
>  /**
>   * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
> + * @pcc_ss_id: pcc subspace id.
>   *
>   * Check and allocate the cppc_pcc_data memory.
>   * In some processor configurations it is possible that same subspace
> @@ -1346,6 +1347,7 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
>
>  /**
>   * cppc_get_transition_latency - returns frequency transition latency in ns
> + * @cpu: CPU for which to get transition latency.
>   *
>   * ACPI CPPC does not explicitly specify how a platform can specify the
>   * transition latency for performance change requests. The closest we have
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 7cf92158008f..6c0fb5c9b938 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -380,6 +380,8 @@ static int dock_in_progress(struct dock_station *ds)
>
>  /**
>   * handle_eject_request - handle an undock request checking for error conditions
> + * @ds: the dock station.
> + * @event: Event code.
>   *
>   * Check to make sure the dock device is still present, then undock and
>   * hotremove all the devices that may need removing.
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index aaea10d39201..95521a8b49fc 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -491,6 +491,7 @@ static void acpi_pm_finish(void)
>
>  /**
>   * acpi_pm_start - Start system PM transition.
> + * @acpi_state: Power state value.
>   */
>  static void acpi_pm_start(u32 acpi_state)
>  {
> @@ -531,6 +532,7 @@ static u32 acpi_suspend_states[] = {
>  /**
>   *     acpi_suspend_begin - Set the target system sleep state to the state
>   *             associated with given @pm_state, if supported.
> + *     @pm_state: pm suspend state.

Well, I appreciate the effort, but this change doesn't really improve
the kerneldoc too much regarding the information provided by it.

In fact, @pm_state is documented already here, you just need to
rearrange this comment.

>   */
>  static int acpi_suspend_begin(suspend_state_t pm_state)
>  {
> @@ -658,6 +660,7 @@ static const struct platform_suspend_ops acpi_suspend_ops = {
>   *             state associated with given @pm_state, if supported, and
>   *             execute the _PTS control method.  This function is used if the
>   *             pre-ACPI 2.0 suspend ordering has been requested.
> + *     @pm_state: pm suspend state.

Pretty much same as above.

>   */
>  static int acpi_suspend_begin_old(suspend_state_t pm_state)
>  {
> @@ -951,6 +954,7 @@ static const struct platform_hibernation_ops acpi_hibernation_ops = {
>   *             ACPI_STATE_S4 and execute the _PTS control method.  This
>   *             function is used if the pre-ACPI 2.0 suspend ordering has been
>   *             requested.
> + *     @stage: pm event massage

And here too.

>   */
>  static int acpi_hibernation_begin_old(pm_message_t stage)
>  {
> --
> 2.25.4
>
