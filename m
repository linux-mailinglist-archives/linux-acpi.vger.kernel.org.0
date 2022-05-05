Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4A051C6B5
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382980AbiEESJJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 14:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382969AbiEESJI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 14:09:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60688B1D2;
        Thu,  5 May 2022 11:05:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y3so10160287ejo.12;
        Thu, 05 May 2022 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+x+x3eAAMOz9rwCXOWTN+T+FLs3SH78JsjnNCjceHg=;
        b=dKPvdDTCIOmho8E5CtGPTl883Ano3OsaIZ1m5vk0So2yVo1c4sTtHQeZkzFOuxbdOM
         qJj/hlHINiqTciZpLb+xKs6BmHqi3MQR3KQBBlcvi8oXJxFj783VWrvp1cqMjDMnOmDt
         +lCbRAvNTBvQBJZBG8eMCFI92IK8t9/DXVKVJ/KjC+RufRkd2boaKLsFkblfULhvIvP9
         IFj9W0jxnKT72EQiTusP0jpGY6PuigIr6CXKUI9im3qeE/4q0ZsnawDiVIl7zyNOBqYG
         hYc0/fdbTA4o11N00n9ba54k84/keY9hVmJDHzkuMng81xyGH9yCY66N1dwaWQSKLnwx
         k0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+x+x3eAAMOz9rwCXOWTN+T+FLs3SH78JsjnNCjceHg=;
        b=KqrnNt9MhxOteGsO0krSKW9A8ZBLkzUrem8sh3P27nTJLEHd97iVUDF0+VqvfEeBIW
         2ctdCkczeTmC8yUJgNJxGOT19lLiLdXApEA/l2K5HeJYIhnvXL+ql1U1RCSkcd5AEipW
         aSBxXsJO9F6sJXaQovckktja0HbEOVIRlkragk1G5QcBBXvghIOgjT8l1dRrrmw1ZfQt
         3uOoctzLLncCaODMKfuAiL5qsW2VkkRKZYgoV7V/YL6SsUkDMIue8EP2BP03R5b9P6A3
         pQ1BH7N7V54VnNkzJvwk4XdVcozrHMEDvadBf0ZuqLTzAXZy5a1T5D7PFC/00pYFwl7d
         hUuA==
X-Gm-Message-State: AOAM530oGIkDsw4eD0ec+Dq9/fqj0NWoLy86+aRA+kYeZHcnB3DJeIIK
        cFSnP3n85Bj7brfrMrqjEpXm8Q1fwmMZ5aXueFY=
X-Google-Smtp-Source: ABdhPJyKdDa/q3PsQDSw9AkVM5GWaz3C7ThxzZrEe9r69mdfIsv629BvvwkOvjwfxn5DQiT4c4IU5CHjwYxUonqMjn0=
X-Received: by 2002:a17:906:c10d:b0:6f4:a770:846e with SMTP id
 do13-20020a170906c10d00b006f4a770846emr13186959ejc.497.1651773925823; Thu, 05
 May 2022 11:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220418141416.27529-1-asmaa@nvidia.com> <CH2PR12MB3895A1FB2977B725ED92AB57D7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CACRpkdY1uK=73zpEM5zUyXacm5xaUUFYkuKMxi_q6vwmOPy6tw@mail.gmail.com> <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB389560A1873030472A7A371DD7C29@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 May 2022 20:04:49 +0200
Message-ID: <CAHp75Vc_-rF+i7U0DAd1Uk4Q+8xwzKidPxYv_Q4Shk__HGUGTg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 5, 2022 at 7:01 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>

Your email is broken.  Please, fix the client or other parts that make
your email unreadable.


-- 
With Best Regards,
Andy Shevchenko
