Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9243B32A
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhJZNdd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 09:33:33 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33491 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbhJZNdc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2021 09:33:32 -0400
Received: by mail-ot1-f42.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so2090626otg.0;
        Tue, 26 Oct 2021 06:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Rw9Rg7tAUZhYOzn5rTnPhKc9NM7ZuHB4PIGGt6nceg=;
        b=ZptIcaLd3Wd4FTXJAFnNR5HVbD6U3NZYdzK7paBRNv2nHXagRQ4slV22N8L+qS7KWL
         57X+1XJd84ELaPbx+os9ZNIWRTPQm88eSAE3j9tfPOfchfwvNcsLdnuA6f9uVM/U2siI
         QjSJxKOaZGJ+Z105Mw46kAooVZMLEWRfP+laeB82J9Y7G0bxSWI63OinJlcc0r1N26FN
         F3FEdzFKSZoanfZ35g6O4RQD/29xKx2B8xjyvjSxvRtgkVWhmfKcZ9jbe5VtTeConGGA
         arcDpO80ewBn85JBjitSArdkDfk2VTwxdWja0sYDou5sxwQ+kz7x+tArliczmhpWdegt
         FeUA==
X-Gm-Message-State: AOAM532YhqVhkkGd1DCA9VIThzXejqUmz9Zaz1XjWI3ClD3aaZl3Xl5p
        OKqlYBaAsxpkgODz7jcmDtmcHSsf2gdVZqgKKfbp1pSz
X-Google-Smtp-Source: ABdhPJxG369zW50RPnDCSVhR8e8gNVyy1sNzWbNuxGC6gnW893GY4d80TEZ5/8Ac3qiOAr6tTErad+gD+A9KDJ1bsi4=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr19089856otd.16.1635255068281;
 Tue, 26 Oct 2021 06:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <1634700197-70709-1-git-send-email-aubrey.li@intel.com>
In-Reply-To: <1634700197-70709-1-git-send-email-aubrey.li@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 15:30:52 +0200
Message-ID: <CAJZ5v0j4T4nKHjr1M5xOFcqpVr=3r+Ta6QeBy2Tr9tZTHquySw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI/PRM: Remove unnecessary blank lines
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 20, 2021 at 5:23 AM Aubrey Li <aubrey.li@intel.com> wrote:
>
> Just remove unnecessary blank lines, no other code changes
>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> ---
>  drivers/acpi/prmt.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 89c22bc..aa02221 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -49,7 +49,6 @@ struct prm_context_buffer {
>  };
>  #pragma pack()
>
> -
>  static LIST_HEAD(prm_module_list);
>
>  struct prm_handler_info {
> @@ -73,7 +72,6 @@ struct prm_module_info {
>         struct prm_handler_info handlers[];
>  };
>
> -
>  static u64 efi_pa_va_lookup(u64 pa)
>  {
>         efi_memory_desc_t *md;
> @@ -88,7 +86,6 @@ static u64 efi_pa_va_lookup(u64 pa)
>         return 0;
>  }
>
> -
>  #define get_first_handler(a) ((struct acpi_prmt_handler_info *) ((char *) (a) + a->handler_info_offset))
>  #define get_next_handler(a) ((struct acpi_prmt_handler_info *) (sizeof(struct acpi_prmt_handler_info) + (char *) a))
>
> @@ -171,7 +168,6 @@ static void *find_guid_info(const guid_t *guid, u8 mode)
>         return NULL;
>  }
>
> -
>  static struct prm_module_info *find_prm_module(const guid_t *guid)
>  {
>         return (struct prm_module_info *)find_guid_info(guid, GET_MODULE);
> --

Applied as 5.16 material along with the [2/2], thanks!
