Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B35683A96
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Feb 2023 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjAaXkP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Jan 2023 18:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjAaXkO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2023 18:40:14 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9AF18A85
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jan 2023 15:40:12 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id 187so17807449vsv.10
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jan 2023 15:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNWJjiHZ40BzwBFNd25x6TMl8GnedoNNCYGCd1mQAeg=;
        b=Nhou7RN5fM5f5cI/iVGIMo21MZVVTKgkyIJL5ORf8vkscx4DIfYfx71Gf+Fu9zwbhI
         jKvjlDNed0CaPq2PJhGvQzp7IjTBlAqw1vBWFiqixPH1NoHRTldioPZEGhWzJQyaUvOM
         QT5DWZTE7nGsM0k6tTPQ0S8mB289q3k5fM4brPNxyCrIy+Usx+m/cH3bFdWUmlouuURb
         USBnNE8XbO5WB5vrnN97xTXbfmeVijTWmnIxELq/aWzoqP6QZzimfRKRCMNzCw9OrGn4
         vcvlAo/7Stbrg8A9eE6oB56vVwKhqzKfQb/NnSDK0PIwV0M/8hEHOKkxCBnSWmX5ge/t
         7BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNWJjiHZ40BzwBFNd25x6TMl8GnedoNNCYGCd1mQAeg=;
        b=z/et5tJ837BA1laGqJZvvnp+W8Mf/RlNaLZliaXfXqcPAtOoyE7DtbqfW43wKijxJ+
         I+PQUESVm5n4pkJsHJORYyjtw3pgMGZOy1fs0ZZJfv3kiU6KzoUmMMULjTAMC99G6GDJ
         54Y/eNsp6cDwpYuGtApxQXBzrfZPmZ3fGaJkK1GykFrjooa0IqQ+ImpHyGW8kVrefd4y
         BwUfdQULP8I5M5yKUQK3G/PInBjS7u9A9n9x6CjgfjsGCeDjWZW94Y/hX1rr/IAAQfIF
         xHfHxT6zXMwRhdIwflNr3/5Zxugo7JfzswCBgLQP7A777tHeYo0ivOx1ZYdrlT8eUrVW
         lHng==
X-Gm-Message-State: AO0yUKU3tmrlC/CfEhoKa/7E3gEgpmWNH5QfP+/aYTZT05AIEZu6SAIz
        w08RJ8WoiUJLRhQ/K+vt+wl/ndmtp8m+1H0fmB0tSA==
X-Google-Smtp-Source: AK7set+LGZpVBUq8jBYUp23fV64plVr7SG2DY47NRbmas+5wk9V9BIThjG1yn8uBo52H/ysiEC+SN+XZvlxAE8uICa8=
X-Received: by 2002:a67:e19a:0:b0:3f7:528b:d25f with SMTP id
 e26-20020a67e19a000000b003f7528bd25fmr138820vsl.9.1675208410993; Tue, 31 Jan
 2023 15:40:10 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 1 Feb 2023 05:10:00 +0530
Message-ID: <CA+G9fYsPSJiTXouaMUSeoU3JEwym0baq7OGOAMFNWgrgEWOHfA@mail.gmail.com>
Subject: Re: ACPICA: Replace fake flexible arrays with flexible array members
To:     Kees Cook <keescook@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>, devel@acpica.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, robert.moore@intel.com,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The qemu-i386 boot failed on Linux next- 20230131 started from
next-20230125. Please refer to boot logs [1], [2] & [3].

The bisection pointed to the following commit,
# first bad commit:
  [5f7e8394a70761036e416c7529c937f309e4680f]
  ACPICA: Replace fake flexible arrays with flexible array members

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Reverting the above patch fixes the qemu-i386 boot problem.

[1] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2L4mi3ZZDct0vwmV2tIVY5AtNr0/logs?format=html
[2] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2L4mi3ZZDct0vwmV2tIVY5AtNr0/logs?format=txt
[3] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2L4mi32cqUyZvCIhJlV5nR8CuQk

Bisection log:
http://ix.io/4mIP

--
Linaro LKFT
https://lkft.linaro.org
