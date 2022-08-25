Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E57C5A10AC
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Aug 2022 14:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiHYMiD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Aug 2022 08:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiHYMiC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Aug 2022 08:38:02 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2ADAF0D6
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 05:38:02 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id n14so11965732qvq.10
        for <linux-acpi@vger.kernel.org>; Thu, 25 Aug 2022 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=oYoPj4ReQjEYKhJJfNZ3/kXGdmITCPifPbUPYtA56sI=;
        b=MpIHkOHsxHnMLnpv85c3AaxqXE294FgYZ0fB1z3CuKeV3cuxLD/2CheaInVqrfzQR3
         wKWe2wP30kXMi/NIvszSJ5zWMDNXv/TyXbLqfzQkt621ww/Zl+gDcmsDTbXRAeUK2kRq
         JbMxFDFltnVcLq9NAtZ8wGzMQLBzaFRWXfGgVuLOmbH578021b11rdrS/AVVlWEwK4/S
         1Psw7OKhEXhg9IzobCrrwNN0VaEHzTQz0+iMXgwVKH+Clospx/H5zMt8R6GFWc15ereE
         qw5aE6m6FnQLHhDulBWtYktD6PLM8joGcjaAAurHEyvv5jao+vYy6mrMiIGEzYcQkf24
         Gxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=oYoPj4ReQjEYKhJJfNZ3/kXGdmITCPifPbUPYtA56sI=;
        b=elqxaQrwzLDS0I0SVTTJaruFtPtxlKmWTnFlWQCc8pNbU2CTQmj6kOpFR44tpdaFuv
         3QrmcX5bZcRIzPTOhuWXJKsqAQWuyAfmMZk/ETPj/JFqZ45AUCWtbTvcxfUcXy61df4B
         UyDAL15FcVw8webVFhO9MxE7AB3Th63WJPTUlpCh5rSjg9Ltmn1giwFroejsXTwWs4MB
         uZSGr5S5LcVhB+XkyGAh9qj7W1LXDKRV3qyHnK0mxr1OJjVoo3cELY2IGItH/HPQZY+Q
         JKizAPChzAf7xktx4wxJ+aaFtA+3t+DVl81hcVbMNy+yBv6V4+0Y4NL/Vcpj8+7tn8WX
         XtcQ==
X-Gm-Message-State: ACgBeo3w/mNZHLNPPWIp/niDbp5y9VrNnGOmzT7hEQItPIyR67JwMVlE
        MWpOOryRU3MHKeu+KC9FxdhLXtHlZA8ivy29k1aiQ4wmfeJjnw==
X-Google-Smtp-Source: AA6agR7SoewizjcIiI2QsXV2x/D96YSquTWaQcSQbn93PgEU4GEoRbLgAuOD7AEKKfWfz3+m/X1kBoZQMBEtXOQpZhg=
X-Received: by 2002:a05:6214:29c2:b0:497:8b2:442 with SMTP id
 gh2-20020a05621429c200b0049708b20442mr3192267qvb.97.1661431081129; Thu, 25
 Aug 2022 05:38:01 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 15:37:25 +0300
Message-ID: <CAHp75VczhmTTdMbj7z2DOPm+k4SWGzuLF8NyJ2FWHwhfg9HJ1Q@mail.gmail.com>
Subject: ACPI ID list termination
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
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

I have stumbled over __acpi_match_device() implementation and noticed
different types of termination of the struct acpi_device_id (ACPI ID
list), i.e. '{ }' vs. '{"", 0}'.

As I read the code of the above mentioned function, I see that it
dereferences the id field without NULL check. This means we are quite
lucky (somebody before guarantees the match) we have no crash here.

So, my question is, if my analysis of the situation is correct, we
need to patch ACPI glue code to be NULL-aware and not rely on any
guarantees, because it seems to me fragile. In that case we may unify
ID list termination as it's done in most cases, i.e. '{ }'.

Opinions, comments?

-- 
With Best Regards,
Andy Shevchenko
