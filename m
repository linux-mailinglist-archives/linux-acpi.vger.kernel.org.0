Return-Path: <linux-acpi+bounces-391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56227B70E0
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 777692813BC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6AB3C689
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 18:32:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CA3C69F
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 18:29:58 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA9AF;
	Tue,  3 Oct 2023 11:29:57 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57ddba5ba84so104083eaf.0;
        Tue, 03 Oct 2023 11:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357796; x=1696962596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKuLyXDaUOfq1uIfw6OusMnl9KqNTsb0JtRvHzmk/hI=;
        b=qQe3AcuO6rLideDcZTfQ2gt6avF+1WZhWg0sDR2ItXn0hz1IY80PmSSZaSQh/IF/g3
         VguzuGSEDwTzDCEmtBzZBhonRqSKLvfvQhwCs30zV2yvEmsaq553PmDNb9Jse4edtEfD
         dWuXxSdTUFBl8RyB0OP1HXi9d8f4q+tmDiR+UDO22bhH+hza/ZRwuniNK77wHFpMJ59Q
         XpTNrcHKdhCmvQmworzI3XsBjQA7MVaZK33NQbPlApTMe34MTgM0P1nqF59gX24174HN
         DoYqwQjCxer5EgwFMGxuePjkcLjh/25qHDf9vbv87FWhPU7L54BZ07hRygO930rdB+g4
         PjCA==
X-Gm-Message-State: AOJu0Yx9COnjXyfCPLi6ByeeYZthNYYtegFXD5EAV8jM03A+/iip6DQ4
	4v6wXJB4jrY1U7j9nrahYgSsNC3y8wgnhSklBdw=
X-Google-Smtp-Source: AGHT+IGfYbL8E3JNC+wKvzaKai74tZwW1E6GU4g6CClDy5JW4gC42y+OnApY8XJwxgpeKFJARKmcdzK14ndUdbcCDDA=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr209370ooo.0.1696357796460; Tue, 03 Oct
 2023 11:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230930090248.34759-1-bergh.jonathan@gmail.com>
In-Reply-To: <20230930090248.34759-1-bergh.jonathan@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 20:29:45 +0200
Message-ID: <CAJZ5v0gDBNzUP8_9ayHniObOz0LriV0=sg4Kqw5GizMH8Aox0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers: acpi: Fix pointer declarations in parameter
 lists which included whitespace spuriously
To: Jonathan Bergh <bergh.jonathan@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 11:03=E2=80=AFAM Jonathan Bergh
<bergh.jonathan@gmail.com> wrote:
>
> Fixed issues where pointer declarations in parameter lists included
> whitespace before the parameter names and should not.
>
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/acpi/osl.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f725813d0cce..29e0005c30aa 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -493,7 +493,7 @@ EXPORT_SYMBOL(acpi_os_unmap_generic_address);
>
>  #ifdef ACPI_FUTURE_USAGE
>  acpi_status
> -acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
> +acpi_os_get_physical_address(void *virt, acpi_physical_address *phys)
>  {
>         if (!phys || !virt)
>                 return AE_BAD_PARAMETER;
> @@ -784,7 +784,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr,=
 u64 value, u32 width)
>
>  #ifdef CONFIG_PCI
>  acpi_status
> -acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
> +acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
>                                u64 *value, u32 width)
>  {
>         int result, size;
> @@ -816,7 +816,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * p=
ci_id, u32 reg,
>  }
>
>  acpi_status
> -acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
> +acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
>                                 u64 value, u32 width)
>  {
>         int result, size;
> @@ -1197,7 +1197,7 @@ bool acpi_queue_hotplug_work(struct work_struct *wo=
rk)
>  }
>
>  acpi_status
> -acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle *=
 handle)
> +acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle *=
handle)
>  {
>         struct semaphore *sem =3D NULL;
>
> @@ -1554,7 +1554,7 @@ void acpi_os_release_lock(acpi_spinlock lockp, acpi=
_cpu_flags flags)
>   ***********************************************************************=
*******/
>
>  acpi_status
> -acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** ca=
che)
> +acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t **cac=
he)
>  {
>         *cache =3D kmem_cache_create(name, size, 0, 0, NULL);
>         if (*cache =3D=3D NULL)
> @@ -1575,7 +1575,7 @@ acpi_os_create_cache(char *name, u16 size, u16 dept=
h, acpi_cache_t ** cache)
>   *
>   ***********************************************************************=
*******/
>
> -acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
> +acpi_status acpi_os_purge_cache(acpi_cache_t *cache)
>  {
>         kmem_cache_shrink(cache);
>         return (AE_OK);
> @@ -1594,7 +1594,7 @@ acpi_status acpi_os_purge_cache(acpi_cache_t * cach=
e)
>   *
>   ***********************************************************************=
*******/
>
> -acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
> +acpi_status acpi_os_delete_cache(acpi_cache_t *cache)
>  {
>         kmem_cache_destroy(cache);
>         return (AE_OK);
> @@ -1614,7 +1614,7 @@ acpi_status acpi_os_delete_cache(acpi_cache_t * cac=
he)
>   *
>   ***********************************************************************=
*******/
>
> -acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
> +acpi_status acpi_os_release_object(acpi_cache_t *cache, void *object)
>  {
>         kmem_cache_free(cache, object);
>         return (AE_OK);
> --

Applied along with the [2-3/3] as 6.7 material with edits in the
subjects and changelogs.

Thanks!

