Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609926E65AF
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Apr 2023 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjDRNS6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 18 Apr 2023 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjDRNS6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Apr 2023 09:18:58 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3C15460
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 06:18:48 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-94a34c299d8so124480266b.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2023 06:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823927; x=1684415927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFIQVXrLFd7q4ga14HgwT435U/mDvwbB8UGP7WQnl88=;
        b=HTa9hSVrer9zt66UDdcrcqcdn69tVMMPibmMNb2r6IfTsytCVHp+/C8FU1oMOntEh0
         OJxbk030y2UWbWn1jknS6++oGziPCiVq0xQ/m106+MxYE1xi0S5n0iFhssTk2+/NhopC
         lW4tnwAaU3sW/3cRoX2AzWjim3RbrqNacpbqgIe1ib8JY89I+rYTnrVTXpout2cuUVW4
         ACbJ11VzDS2IDo6T0NzVg+0AZHyOvbL1p6zQvIuCWPRp8P2AlDs0Da14yLfQHmrcltdF
         RFdAlFb3Tx8DBDYrF8NJbWfaTqCJzbO4CyLJfAaPnpLz1bkmPGRQVPSWb8VUOQFySZG7
         iTtA==
X-Gm-Message-State: AAQBX9c2FQFK7Z4q6EIchs5OA74j1Jvb4p9kFpFwgAIdIAiR8ksZOiGY
        TpbO0jCGodfCiqzc/S5GpdQgfUYkYyldoNjiP5va8aN5
X-Google-Smtp-Source: AKy350YRNEU73tdEqaP7TGNwcUwZ5kxySJqtcBNM4+etDSz+v1Qm5SC+G8dBXXMa+y/h/OlUh8nPnCFM3iTfK3p2g1o=
X-Received: by 2002:a17:906:72dd:b0:92f:27c2:13c0 with SMTP id
 m29-20020a17090672dd00b0092f27c213c0mr12808558ejl.6.1681823926547; Tue, 18
 Apr 2023 06:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230410144846.1959224-1-guodongtai@kylinos.cn>
In-Reply-To: <20230410144846.1959224-1-guodongtai@kylinos.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 15:18:35 +0200
Message-ID: <CAJZ5v0iZ4Vf+-SBaUHY7aYg6tJ74wFLWm3y3=XALxrusW8raqg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Modify ACPI_STATE_COMMON and put it in a single line
To:     George Guo <guodongtai@kylinos.cn>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 10, 2023 at 4:49 PM George Guo <guodongtai@kylinos.cn> wrote:
>
> Avoid trailing semicolons in macro, and it's not readable to put the macro
> ACPI_STATE_COMMON with other variables in the same line.
> So modify the macro and just put it in a single line.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

ACPICA changes need to be submitted to the upstream project on GitHub
in the first place.

When you have an upstream ACPICA pull request corresponding to this
patch, please resend the patch with a Link: tag pointing to that pull
request.

Thanks!

> ---
>  drivers/acpi/acpica/aclocal.h | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 901b1543b869..cb757ac2c22e 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -560,25 +560,28 @@ struct acpi_field_info {
>         u8                              descriptor_type; /* To differentiate various internal objs */\
>         u8                              flags; \
>         u16                             value; \
> -       u16                             state;
> +       u16                             state
>
>         /* There are 2 bytes available here until the next natural alignment boundary */
>
>  struct acpi_common_state {
> -ACPI_STATE_COMMON};
> +       ACPI_STATE_COMMON;
> +};
>
>  /*
>   * Update state - used to traverse complex objects such as packages
>   */
>  struct acpi_update_state {
> -       ACPI_STATE_COMMON union acpi_operand_object *object;
> +       ACPI_STATE_COMMON;
> +       union acpi_operand_object *object;
>  };
>
>  /*
>   * Pkg state - used to traverse nested package structures
>   */
>  struct acpi_pkg_state {
> -       ACPI_STATE_COMMON u32 index;
> +       ACPI_STATE_COMMON;
> +       u32 index;
>         union acpi_operand_object *source_object;
>         union acpi_operand_object *dest_object;
>         struct acpi_walk_state *walk_state;
> @@ -591,7 +594,8 @@ struct acpi_pkg_state {
>   * Allows nesting of these constructs
>   */
>  struct acpi_control_state {
> -       ACPI_STATE_COMMON u16 opcode;
> +       ACPI_STATE_COMMON;
> +       u16 opcode;
>         union acpi_parse_object *predicate_op;
>         u8 *aml_predicate_start;        /* Start of if/while predicate */
>         u8 *package_end;        /* End of if/while block */
> @@ -602,11 +606,13 @@ struct acpi_control_state {
>   * Scope state - current scope during namespace lookups
>   */
>  struct acpi_scope_state {
> -       ACPI_STATE_COMMON struct acpi_namespace_node *node;
> +       ACPI_STATE_COMMON;
> +       struct acpi_namespace_node *node;
>  };
>
>  struct acpi_pscope_state {
> -       ACPI_STATE_COMMON u32 arg_count;        /* Number of fixed arguments */
> +       ACPI_STATE_COMMON;
> +       u32 arg_count;  /* Number of fixed arguments */
>         union acpi_parse_object *op;    /* Current op being parsed */
>         u8 *arg_end;            /* Current argument end */
>         u8 *pkg_end;            /* Current package end */
> @@ -618,7 +624,8 @@ struct acpi_pscope_state {
>   * states are created when there are nested control methods executing.
>   */
>  struct acpi_thread_state {
> -       ACPI_STATE_COMMON u8 current_sync_level;        /* Mutex Sync (nested acquire) level */
> +       ACPI_STATE_COMMON;
> +       u8 current_sync_level;  /* Mutex Sync (nested acquire) level */
>         struct acpi_walk_state *walk_state_list;        /* Head of list of walk_states for this thread */
>         union acpi_operand_object *acquired_mutex_list; /* List of all currently acquired mutexes */
>         acpi_thread_id thread_id;       /* Running thread ID */
> @@ -629,8 +636,8 @@ struct acpi_thread_state {
>   * AML arguments
>   */
>  struct acpi_result_values {
> -       ACPI_STATE_COMMON
> -           union acpi_operand_object *obj_desc[ACPI_RESULTS_FRAME_OBJ_NUM];
> +       ACPI_STATE_COMMON;
> +       union acpi_operand_object *obj_desc[ACPI_RESULTS_FRAME_OBJ_NUM];
>  };
>
>  typedef
> @@ -652,7 +659,8 @@ struct acpi_global_notify_handler {
>   * handler/dispatcher.
>   */
>  struct acpi_notify_info {
> -       ACPI_STATE_COMMON u8 handler_list_id;
> +       ACPI_STATE_COMMON;
> +       u8 handler_list_id;
>         struct acpi_namespace_node *node;
>         union acpi_operand_object *handler_list_head;
>         struct acpi_global_notify_handler *global;
> --
> 2.34.1
>
