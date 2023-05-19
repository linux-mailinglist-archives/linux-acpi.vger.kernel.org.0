Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B032709F4A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjESSoM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESSoL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:44:11 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D226E43
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:44:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso5535037a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684521848; x=1687113848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP0roWAg79GmNnTX3PActukmpsHrXoYZPfWyNU+CGOc=;
        b=XzfMn2+xMQxSD4yOtkkYJSoocxFa6IRMYl4mivx7mjMgkuWlajFoErGAXzRctR986V
         qAcRzGOC9YNFf2FY00DcJMqNTuK4x4xg5QqDnrNoO6he4tPvitXfqOAGBw17RPtUqw8F
         J/pj8d44//1dOqbAMy5DPcoWjhWaCgBtOQqM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684521848; x=1687113848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP0roWAg79GmNnTX3PActukmpsHrXoYZPfWyNU+CGOc=;
        b=D1ZeM3KUcr+4pp82CjqYottUXIe3QdqYtK9ymVAxsarNkfKt0XeR44dVzYrUVnZqh1
         n0qTywKEJkGcdM1NVEF8x4Xm6fzagxABwJtY996qZhazecbonVr3dZQxCCjZ5Ippelb2
         6bUS3gr1P2uvjqVRPsaquCuO29LAUfUmF/FIqsPErqDDdAjTwHg1fgeTyOUgPA0yD0U4
         nDPIIcv7VL6w1/bQgTBRpNBlAc8EFsHVXEiF04lO16MJt96wFxlXYMTm9Sp5VOks0BiJ
         AxUCwPhbaG6xsn4ZidTCLELptqDQuIpW+fO82R8DpYYw66/nrm7Jgavl5FifLlPTdi+t
         R/Ug==
X-Gm-Message-State: AC+VfDyGPs9KtnoJgzgPi/GzGPhLBEcqeqDfgP1vtgmezuJ5Zsx26ybA
        uCUwbkIOcfGhuv9FqCu122VpR/jhVqncwJY1ECtsdFtf
X-Google-Smtp-Source: ACHHUZ4V5fi8T+yWy7JTBezoHAjM2rYN/o4zoHqgZQb4sueUj6BcYaXIQmDcDfGrAqVBC+idaR2pqw==
X-Received: by 2002:a17:906:5044:b0:96a:3e39:f567 with SMTP id e4-20020a170906504400b0096a3e39f567mr2323181ejk.47.1684521848449;
        Fri, 19 May 2023 11:44:08 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id rl6-20020a170907216600b0096f55247570sm1505594ejb.0.2023.05.19.11.44.07
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 11:44:08 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-96f850b32caso69761166b.3
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 11:44:07 -0700 (PDT)
X-Received: by 2002:a17:906:fd85:b0:961:78c2:1d27 with SMTP id
 xa5-20020a170906fd8500b0096178c21d27mr2552006ejb.19.1684521847716; Fri, 19
 May 2023 11:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g9RmqJm=bpc9SQryYo4r+9Ctj7_aXQcfFRWTS3=xs6qw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 11:43:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZqMhLk6qbcO-pQSPFh2v-iu8v0A8U=mppYjLVHkf0Pw@mail.gmail.com>
Message-ID: <CAHk-=whZqMhLk6qbcO-pQSPFh2v-iu8v0A8U=mppYjLVHkf0Pw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fix for v6.4-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 19, 2023 at 8:28=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> This adds an ACPI IRQ override quirk for LG UltraPC 17U70P so as to
> make the internal keyboard work on that machine (Rub=C3=A9n G=C3=B3mez).

I've pulled this, but those overrides are just odd. How does Windows
work on those machines?

This feels like we're missing something...

             Linus
