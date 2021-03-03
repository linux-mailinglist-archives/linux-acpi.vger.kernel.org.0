Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D932C443
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388185AbhCDAML (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:12:11 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40550 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239656AbhCCSkA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2021 13:40:00 -0500
Received: by mail-ot1-f48.google.com with SMTP id b8so24531297oti.7
        for <linux-acpi@vger.kernel.org>; Wed, 03 Mar 2021 10:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNfMFUqnbfRpKmfbEhIdl0ckJQF8TkIoj1h40G0Tu3k=;
        b=axa5T3Dx7f9rms3CWMAkBwtlA0kOqtLNlDPkYJRi0iHjLm5Imr+yKyCXOZSG+bfIy2
         ZaMIjdmBtMI1iUtZZc9z0O4a7BNc4vfs6ImWYlJwVDxfGrVmf/3iTJPfobTVqmS1xtHE
         LSG9YOm/8VDAc5YJ3V/iG5mRTmSD1LLTFfhIa1vlmPddykqIc7xPaJ7oMTsyy3fi+MRg
         BnvAjToTykm+DKvRYc9kusHHlgdw6tU98l3Q4Gezhqa2m08XKwISCAsqpYDKZsTXYOVE
         CFA0HX7gw8R9cZ+o8c68uB5EVmURMGJ47xcfysBMm9K4iTOFSIFyS8F0gtB19sFRFHgX
         PW0g==
X-Gm-Message-State: AOAM531gPvrNFWgk6pULg39u9gx+m/842DKbDViClYD6cT3ZNjX4yktD
        PUTX0ucEClsOKOx8YXJPFgoqgi9vPO5MDZPCAPAjnFN8
X-Google-Smtp-Source: ABdhPJxmCC/yDMuO9tMBebnhdnU57Pz1ckuktYXiXAS6ScP/TEtG/cIrYqqo7cqBZVnhAS1mQfqfvnTaKrTMiod1y5o=
X-Received: by 2002:a05:6830:2046:: with SMTP id f6mr319605otp.321.1614796709635;
 Wed, 03 Mar 2021 10:38:29 -0800 (PST)
MIME-Version: 1.0
References: <1614041789-28216-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1614041789-28216-1-git-send-email-tiantao6@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Mar 2021 19:38:18 +0100
Message-ID: <CAJZ5v0gc_pWr0hOHU0A_rohMijji_u2p4yxwGzA6+P1NaPBfkA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Remove initialization of static variables
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 23, 2021 at 1:57 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Address the following checkpatch errors:
> ERROR: do not initialise statics to false
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/acpi/processor_perflib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index 32f0f55..91c401e 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -459,7 +459,7 @@ int acpi_processor_pstate_control(void)
>
>  int acpi_processor_notify_smm(struct module *calling_module)
>  {
> -       static int is_done = 0;
> +       static int is_done;
>         int result;
>
>         if (!acpi_processor_cpufreq_init)
> --

Applied as 5.13 material with minor edits in the subject and changelog, thanks!
