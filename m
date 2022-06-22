Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D518554A52
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jun 2022 14:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiFVMuW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jun 2022 08:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347612AbiFVMuV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2022 08:50:21 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676019039
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 05:50:19 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3178acf2a92so127629697b3.6
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 05:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjImQd/ow4ise4Z8zr9ZK5lwVyVw0hn736HAa5U/9Ek=;
        b=vb4S1j9xSEIw6KuMBkyoZPjgNJFfJIHjd9jFrRzG42VKhN+w3/f9SJgmFl2Zsn2NAR
         LkaI7kTMx5IGrnrXUXBKtWvI2vya/aUbDrFQ2LwnaXetp36Z72z5TNC5Zz1saPhBwPnO
         /FCs0hcWYS7rENYl88GVdnkm8///lOB8UIoc8ByifL4gttjlO/56VIEbZs8oQ8g660Jy
         W3lDaCqNunFYguJuqT2yfV2kvUOIYQ5L5pT0d66XaA+9JHV1nmk/05/mpXAKMzD1SSNn
         48Y0El2RIE5cjeBKdRiqzMd9oHkrnKA+Zgz91ZNB03bAj0v496JVIt7a7AYvqsm98zVj
         Q0YQ==
X-Gm-Message-State: AJIora+2dYxghATSHBkHZ6aPnEVMit1v4NgBucEqgBeSFDvHzh95fYp2
        wlQpRHHlHT1qeUIO6HcaSHvTkxkHsYQdFqPXuT0=
X-Google-Smtp-Source: AGRyM1vkylxwgQxriMQkeegWzZV9FCFxuREkfWa5W45QoNyFuu5PUU9vxfh0mHk/0IzWltB9GP4zmprU5DQlq+4IkbM=
X-Received: by 2002:a81:57d7:0:b0:317:b111:34d5 with SMTP id
 l206-20020a8157d7000000b00317b11134d5mr4114819ywb.7.1655902218957; Wed, 22
 Jun 2022 05:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220616090106.2154906-1-sudeep.holla@arm.com> <20220616090106.2154906-2-sudeep.holla@arm.com>
In-Reply-To: <20220616090106.2154906-2-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jun 2022 14:50:08 +0200
Message-ID: <CAJZ5v0j0Ayb3KGpfxuuXH9CHUrt8rupVg5OK=r6hqZQEYm3jFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPICA: Add support for FFH Opregion special context data
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 16, 2022 at 11:01 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> FFH(Fixed Function Hardware) Opregion is approved to be added in ACPIC 6.5 via

s/ACPIC/ACPI/

> code first approach[1]. It requires special context data similar to GPIO and
> Generic Serial Bus as it needs to know platform specific offset and length.
>
> Add support for the special context data needed by FFH Opregion.
>
> FFH OpRegion enables advanced use of FFH on some architectures. For example,
> it could be used to easily proxy AML code to architecture-specific behavior
> (to ensure it is OS initiated)
>
> Actual behavior of FFH is ofcourse architecture specific and depends on
> the FFH bindings. The offset and length could have arch specific meaning
> or usage.
>
> [1] https://bugzilla.tianocore.org/show_bug.cgi?id=3598
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

This looks reasonable to me and I see that you've already submitted a
pull request to the upstream ACPICA.

> ---
>  drivers/acpi/acpica/evregion.c | 8 ++++++++
>  drivers/acpi/acpica/exfield.c  | 8 ++++++--
>  drivers/acpi/acpica/exserial.c | 6 ++++++
>  include/acpi/acconfig.h        | 2 ++
>  include/acpi/actypes.h         | 7 +++++++
>  5 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
> index b96b3a7e78e5..d5aed3249630 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -172,6 +172,14 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>                         ctx->subspace_id = (u8)region_obj->region.address;
>                 }
>
> +               if (region_obj->region.space_id ==
> +                       ACPI_ADR_SPACE_FIXED_HARDWARE) {
> +                       struct acpi_ffh_info *ctx =
> +                           handler_desc->address_space.context;
> +
> +                       ctx->offset = region_obj->region.address;
> +                       ctx->length = region_obj->region.length;
> +               }
>                 /*
>                  * We must exit the interpreter because the region setup will
>                  * potentially execute control methods (for example, the _REG method
> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> index 2b89a496de65..657f4002f9dc 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -141,7 +141,9 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
>                     || obj_desc->field.region_obj->region.space_id ==
>                     ACPI_ADR_SPACE_IPMI
>                     || obj_desc->field.region_obj->region.space_id ==
> -                   ACPI_ADR_SPACE_PLATFORM_RT)) {
> +                   ACPI_ADR_SPACE_PLATFORM_RT
> +                   || obj_desc->field.region_obj->region.space_id ==
> +                   ACPI_ADR_SPACE_FIXED_HARDWARE)) {
>
>                 /* SMBus, GSBus, IPMI serial */
>
> @@ -305,7 +307,9 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
>                     || obj_desc->field.region_obj->region.space_id ==
>                     ACPI_ADR_SPACE_IPMI
>                     || obj_desc->field.region_obj->region.space_id ==
> -                   ACPI_ADR_SPACE_PLATFORM_RT)) {
> +                   ACPI_ADR_SPACE_PLATFORM_RT
> +                   || obj_desc->field.region_obj->region.space_id ==
> +                   ACPI_ADR_SPACE_FIXED_HARDWARE)) {
>
>                 /* SMBus, GSBus, IPMI serial */
>
> diff --git a/drivers/acpi/acpica/exserial.c b/drivers/acpi/acpica/exserial.c
> index 4da20d7845df..fd63f2042514 100644
> --- a/drivers/acpi/acpica/exserial.c
> +++ b/drivers/acpi/acpica/exserial.c
> @@ -323,6 +323,12 @@ acpi_ex_write_serial_bus(union acpi_operand_object *source_desc,
>                 function = ACPI_WRITE;
>                 break;
>
> +       case ACPI_ADR_SPACE_FIXED_HARDWARE:
> +
> +               buffer_length = ACPI_FFH_INPUT_BUFFER_SIZE;
> +               function = ACPI_WRITE;
> +               break;
> +
>         default:
>                 return_ACPI_STATUS(AE_AML_INVALID_SPACE_ID);
>         }
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> index c3ae3ea88e17..02e57191c1fd 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -190,6 +190,8 @@
>
>  #define ACPI_PRM_INPUT_BUFFER_SIZE      26
>
> +#define ACPI_FFH_INPUT_BUFFER_SIZE      144
> +
>  /* _sx_d and _sx_w control methods */
>
>  #define ACPI_NUM_sx_d_METHODS           4
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 3491e454b2ab..1b4f81f1ac5d 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1115,6 +1115,13 @@ struct acpi_pcc_info {
>         u8 *internal_buffer;
>  };
>
> +/* Special Context data for FFH Opregion (ACPI 6.5) */
> +
> +struct acpi_ffh_info {
> +       u64 offset;
> +       u64 length;
> +};
> +
>  typedef
>  acpi_status (*acpi_adr_space_setup) (acpi_handle region_handle,
>                                      u32 function,
> --
> 2.36.1
>
