Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2DC70E211
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbjEWQob (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 May 2023 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbjEWQo3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 12:44:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A01E192
        for <linux-acpi@vger.kernel.org>; Tue, 23 May 2023 09:44:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d1e96c082so4386664b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 23 May 2023 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684860262; x=1687452262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9iP1ZVb5yqMQbzkFbXlAZweX7OqrHaDEWkJHs5lGVQ=;
        b=ntFQNonFSdidYKpES2RkJ39j44/LM+NMO0LxTwaAQig4V8Avhkp579EAxvp69JQolW
         bMpaPjNXCNJH1TsBHnTC9YdHFofv9KHiHg5AQoGw84dhBrNaYKX1EGcjScDwfbUtifj8
         RucUpo604PEzUZDSWfBZcsx29hrKDyWkVM1XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860262; x=1687452262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9iP1ZVb5yqMQbzkFbXlAZweX7OqrHaDEWkJHs5lGVQ=;
        b=cWUok5HWEofg4E2/pUjqYWS3bZC73rzmB7D7V4FGFFsM1lGEVDWA7vYAHkznZ9n639
         A1UkJiXmaE3BXbiVX2fWro8QaA0BsHgKVRv23HkWauif/LET39iJH3fV2LdvADunmsm4
         S/Ummx7/77pVAXRgHHqw1ZB7qmSEoI2QQISX9JcXpvck7/0ilv0YsIuEeo64drrz9+rJ
         iJ8Iajk6ijIMPUouXiGmXnbKhejOGTWEVMlBcFQguOdGHc54z/O+nm33puxItS2+hsIN
         lvsy7hmG9ChKhqmdR0AlVvM3SbRUDmB1Y+nCHW3+K5kF6iBI+2uLJIvh/BXF4wpjEVMv
         SoHQ==
X-Gm-Message-State: AC+VfDzJdoPEJk2J4EmKa3A3mgYU8Q401AY6o8akLQqHPpeRQPC79r9q
        HZYY94U3eMXyxAPe3G2PaRTB+g==
X-Google-Smtp-Source: ACHHUZ4/+01CYAGjUnIF41KOaeHL0XqDcUQVOFVd0foSRmpyDh7GX/XjdRymM50XqVjzfoB85asBeQ==
X-Received: by 2002:a17:902:e848:b0:1ac:b144:c796 with SMTP id t8-20020a170902e84800b001acb144c796mr17400127plg.34.1684860261893;
        Tue, 23 May 2023 09:44:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001a9bfd4c5dfsm7001000plb.147.2023.05.23.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:44:21 -0700 (PDT)
Date:   Tue, 23 May 2023 09:44:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: Replace struct acpi_table_slit 1-element array
 with flex-array
Message-ID: <202305230943.0B7B2F73F@keescook>
References: <20230523161815.3083-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523161815.3083-1-wyes.karny@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 23, 2023 at 04:18:15PM +0000, Wyes Karny wrote:
> struct acpi_table_slit is used for copying System Locality Information
> Table data from ACPI tables. Here `entry` is a flex array but it was
> using ancient 1-element fake flexible array, which has been deprecated.
> Replace it with a C99 flexible array.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Eek, thanks. I missed one! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
