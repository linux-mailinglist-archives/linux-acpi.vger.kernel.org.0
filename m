Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA01859C4F9
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Aug 2022 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiHVR0N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Aug 2022 13:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHVR0M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Aug 2022 13:26:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26132ED68
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 10:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F0ABB81674
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 17:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844C8C433C1
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 17:26:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WOSbkElZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1661189166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnY3Zs/cRAHXtTxO1dLszbSBvp6jMLq/it9dgM2EyMo=;
        b=WOSbkElZXVO8UFwXi8u5sjQRFqtQYIm+bJ6C2CVUGbOSCGiNkm/L4UlYKsNzlOJuhwxjiA
        d/xgCj1eD2Muc8S9aXBhyaBxvHWQ27hDwBRf+MOfcZzwBU/1PwFs04C+5LDNBq6r1dGwjq
        BXOOAaASue1x+LNeU/7o//a7p5JPv+g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bb855e91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-acpi@vger.kernel.org>;
        Mon, 22 Aug 2022 17:26:06 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-32a09b909f6so313696547b3.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2022 10:26:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo1DnD1lXwqiSn70Nv7LOMUL4vRRN6AqZz4driivIwuQ15qDxCf7
        9rapAbGhUnWTbDDbFQ3Pq56VOMC1VhBbzpjGKWg=
X-Google-Smtp-Source: AA6agR461f3/UnEhDaG9VfM493nYy1bKmmx5j6/UzSuAmV/EoTnDBhJz0tluW2lBwClYiOJFsgAc8zn8fiIfQHLaOfM=
X-Received: by 2002:a25:7cc6:0:b0:67a:6a2e:3d42 with SMTP id
 x189-20020a257cc6000000b0067a6a2e3d42mr21010673ybc.231.1661189165779; Mon, 22
 Aug 2022 10:26:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:2589:b0:191:2a95:8ff9 with HTTP; Mon, 22 Aug 2022
 10:26:05 -0700 (PDT)
In-Reply-To: <CAJZ5v0jdOguaacSzB1jxQZVoJ3RSjZY1M07XdKHmLv6EpoqX_A@mail.gmail.com>
References: <YwDsy3ZUgTtlKH9r@zx2c4.com> <CAJZ5v0jdOguaacSzB1jxQZVoJ3RSjZY1M07XdKHmLv6EpoqX_A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 22 Aug 2022 13:26:05 -0400
X-Gmail-Original-Message-ID: <CAHmME9pQ5v5afkcCXtCYc1PLKKbnQJp=mc9gtdF+DBvFbKDPYw@mail.gmail.com>
Message-ID: <CAHmME9pQ5v5afkcCXtCYc1PLKKbnQJp=mc9gtdF+DBvFbKDPYw@mail.gmail.com>
Subject: Re: null ptr deref in __power_supply_is_system_supplied
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I just reproduced in 5.19 actually. Interesting...
