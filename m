Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC536C1E97
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Mar 2023 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCTRwF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 20 Mar 2023 13:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCTRve (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Mar 2023 13:51:34 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F6611A
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2023 10:45:55 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id h8so49969602ede.8
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2023 10:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF5gC3zESEyY3F9XDRkukZCzevvIagvPv8svZuClDI4=;
        b=ZxEiSaUV0WZKyhg0aVIE78ffEZFwO6u9UzzaaAKmMSNnFxrTtvYL+UNEhbOZbJmuJa
         jn3gYZKdMVdK5MQSP4lG3OhIQSq8t7xRJTOLVW07TB8T4JK7QidUj2qHRzbrToK4zfXd
         NRhWDeHn4zQNVJ1zMAs3tx6ehY1yNoPbTZfuGAgDvOBVcpp4mzVzxCGlIOidfDcVJPkI
         sE/94G2u5FUbLqJ4EUCFTAfbR414e0xsJwwRt9FOCEGl5lDR7vOJ+qP+dHbpQKW559lq
         W1eY5CPh5IjbBeln7hWqVvL6vmbZGP8ZPILoeOt9vPA2HS/o3kxnxjhc7CYJMZke1gFU
         GRbg==
X-Gm-Message-State: AO0yUKU4trWJwXbnIiSAwQea5qv47MytLJUjFsz8L5TdSLUO2KHHGXUt
        y1jnlxBjCny86X60THLQXMsoSNQkEX6h20B346BFJ2Vc
X-Google-Smtp-Source: AK7set8WZ1vSViwvRbiMXtPzQh/svm98UiVMlb+n4Iqy4zFb2TaY4bA9Ma6mlA0Ab8sFleYXKjiqsahjGOyim996ilc=
X-Received: by 2002:a17:906:1b4e:b0:931:f8b1:4474 with SMTP id
 p14-20020a1709061b4e00b00931f8b14474mr4590615ejg.2.1679334338454; Mon, 20 Mar
 2023 10:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230316071715.2403-1-kiran.k@intel.com>
In-Reply-To: <20230316071715.2403-1-kiran.k@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:45:27 +0100
Message-ID: <CAJZ5v0h940U120EcknBE6YU_TM_LoqJjnEgff13MOx5Y+xOPbQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: utils: acpi_evaluate_dsm_typed - fix
 redefinition error
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-acpi@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com, luiz.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 16, 2023 at 8:06 AM Kiran K <kiran.k@intel.com> wrote:
>
> acpi_evaluate_dsm_typed function needs to be gaurded with CONFIG_ACPI to
> avoid redefintion error when stub is also enabled.
>
> In file included from ../drivers/bluetooth/btintel.c:13:
> ../include/acpi/acpi_bus.h:57:1: error: redefinition of 'acpi_evaluate_dsm_typed'
>    57 | acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid,..
>       | ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from ../drivers/bluetooth/btintel.c:12:
> ../include/linux/acpi.h:967:34: note: previous definition of
> 'acpi_evaluate_dsm_typed' with type 'union acpi_object *(void *,
> const guid_t *, u64,  u64,  union acpi_object *, acpi_object_type)'
> {aka 'union acpi_object *(void *, const guid_t *, long long unsigned int,
> long long unsigned int,  union acpi_object *, unsigned int)'}
>   967 | static inline union acpi_object
> *acpi_evaluate_dsm_typed(acpi_handle handle,
>
> Fixes: 1b94ad7ccc21 ("ACPI: utils: Add acpi_evaluate_dsm_typed() and acpi_check_dsm() stubs")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>
> Steps to reproduce:
> 1. Apply this bluetooth specific patch - https://patchwork.kernel.org/project/bluetooth/patch/20230313151549.15791-1-kiran.k@intel.com/
> 2. Follow the steps suggedted by lkp bot to compile bluetooth
>
>  include/acpi/acpi_bus.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index e44be31115a6..fc131b4aee4e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -52,7 +52,7 @@ bool acpi_dock_match(acpi_handle handle);
>  bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
>  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
>                         u64 rev, u64 func, union acpi_object *argv4);
> -
> +#ifdef CONFIG_ACPI
>  static inline union acpi_object *
>  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>                         u64 func, union acpi_object *argv4,
> @@ -68,6 +68,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>
>         return obj;
>  }
> +#endif
>
>  #define        ACPI_INIT_DSM_ARGV4(cnt, eles)                  \
>         {                                               \
> --

Applied (with some edits in the subject and changelog) as 6.4 material, thanks!
