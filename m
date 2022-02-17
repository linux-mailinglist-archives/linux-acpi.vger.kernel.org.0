Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024014B9D8C
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Feb 2022 11:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiBQKtJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Feb 2022 05:49:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiBQKtJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Feb 2022 05:49:09 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9781ED1DB
        for <linux-acpi@vger.kernel.org>; Thu, 17 Feb 2022 02:48:54 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2d6923bca1aso18165557b3.9
        for <linux-acpi@vger.kernel.org>; Thu, 17 Feb 2022 02:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cs9Th8M4apHjGs2KFhGILUvXDgQHRaRC8zub7Hxk0Wk=;
        b=ybAOdoACB+zlkQKWmN4Z+b4bHLSWoND3nh6beCeFqTi0gk9b7Nmc+MKxa6dkaTB3Ca
         RYoaeLd7GIQOqS9eRo1X+gYVXwTxaADIn/viU72pMCl5aJgEAbn8/4IcWnhX7WXDomOS
         uk1wBA4pYCI69qWjolLKhx4p89XpFIdXk4GFFbpaGu9PLhLezK6y69UhN2cRGuZ7lQPc
         xi20bUvhAUuiNQT+brvSQkzKEXqodlHfF2m6MH73xXtGnWqH2nPSy9TpM5YpZEDXH/1n
         1sOAJ3bbBbFQTph6Z8MhL2Y62SW+Vy6Kkx3CSO67kmZIkHfCbl1j3Af0zcb9O4av/JPa
         zjrg==
X-Gm-Message-State: AOAM530aYmN3IU7+qlZrQraOwFWqkyaL3fn2rfY1A7rcQi9ZfQdz9+v3
        NNX/UThlHppKBO5ZR5FFqCr8ge9ir7KZ4VZ3g39CYdhkJHU=
X-Google-Smtp-Source: ABdhPJzDwtFjQuEl3Qvy2ZZiWM/e9C5GHpQpOwJDqeVb2w1hcx6XPn1/jOCKUYB1HqlaNmHMrotINCyJcTkGB56aqz0=
X-Received: by 2002:a0d:e8d2:0:b0:2d6:1743:4023 with SMTP id
 r201-20020a0de8d2000000b002d617434023mr2001564ywe.7.1645094933233; Thu, 17
 Feb 2022 02:48:53 -0800 (PST)
MIME-Version: 1.0
References: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157C5EA5510F0C9D7782AE8E2369@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Feb 2022 11:48:41 +0100
Message-ID: <CAJZ5v0g81BmytcjgChXZumsHV5-byzSzDQbp2hc6CYzJ_6N=aw@mail.gmail.com>
Subject: Re: Regression in 5.16-rc1 with suspend to idle
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 17, 2022 at 7:15 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> Hi Rafael,
>
> I've found recently that on kernel 5.17-rc4 some OEM AMD laptops are shutting down when entering suspend to idle.

Interesting.  Can you identify the exact point when the shutdown occurs?

> I bisected this back to commit 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle path")
> which was introduced in 5.16-rc1.  As this code has changed since 5.16-rc1 (notably 23f62d7ab25), a simple revert
> won't suffice.
>
> # good: [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15
> git bisect good 8bb7eca972ad531c9b149c0a51ab43a417385813
> # bad: [fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf] Linux 5.16-rc1
> git bisect bad fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> # bad: [313b6ffc8e90173f1709b2f4bf9d30c4730a1dde] Merge tag 'linux-kselftest-kunit-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
> git bisect bad 313b6ffc8e90173f1709b2f4bf9d30c4730a1dde
> # good: [84882cf72cd774cf16fd338bdbf00f69ac9f9194] Revert "net: avoid double accounting for pure zerocopy skbs"
> git bisect good 84882cf72cd774cf16fd338bdbf00f69ac9f9194
> # good: [79ef0c00142519bc34e1341447f3797436cc48bf] Merge tag 'trace-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
> git bisect good 79ef0c00142519bc34e1341447f3797436cc48bf
> # good: [0f3d2b680444d5697650b5529c9e749acbf7371f] drm/amdkfd: protect raven_device_info with KFD_SUPPORT_IOMMU_V2
> git bisect good 0f3d2b680444d5697650b5529c9e749acbf7371f
> # good: [a64a325bf6313aa5cde7ecd691927e92892d1b7f] Merge tag 'afs-next-20211102' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
> git bisect good a64a325bf6313aa5cde7ecd691927e92892d1b7f
> # good: [d9bd054177fbd2c4762546aec40fc3071bfe4cc0] Merge tag 'amd-drm-next-5.16-2021-10-29' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
> git bisect good d9bd054177fbd2c4762546aec40fc3071bfe4cc0
> # bad: [833db72142b93a89211c1e43ca0a1e2e16457756] Merge tag 'pm-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect bad 833db72142b93a89211c1e43ca0a1e2e16457756
> # good: [33fb42636a938be01d951b4cee68127a59a1e7e4] Merge branch 'ucount-fixes-for-v5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
> git bisect good 33fb42636a938be01d951b4cee68127a59a1e7e4
> # good: [c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb] Merge tag 'acpi-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect good c0d6586afa3546a3d148cf4b9d9a407b4f79d0bb
> # bad: [b62b306469b36fae7030c0ad4ffa11de0c9b9957] Merge branch 'pm-sleep'
> git bisect bad b62b306469b36fae7030c0ad4ffa11de0c9b9957
> # good: [1fec16118ff9b822431d83a16430de60cf8e8769] Merge branch 'pm-pci'
> git bisect good 1fec16118ff9b822431d83a16430de60cf8e8769
> # good: [928265e3601cde78c7e0a3e518a93b27defed3b1] PM: sleep: Do not let "syscore" devices runtime-suspend during system transitions
> git bisect good 928265e3601cde78c7e0a3e518a93b27defed3b1
> # bad: [9f6abfcd67aae51374b4e8aa0b11f0ebd0d8562f] PM: suspend: Use valid_state() consistently
> git bisect bad 9f6abfcd67aae51374b4e8aa0b11f0ebd0d8562f
> # bad: [23f62d7ab25bd1a7dbbb89cfcd429df7735855af] PM: sleep: Pause cpuidle later and resume it earlier during system transitions
> git bisect bad 23f62d7ab25bd1a7dbbb89cfcd429df7735855af
> # bad: [8d89835b0467b7e618c1c93603c1aff85a0c3c66] PM: suspend: Do not pause cpuidle in the suspend-to-idle path
> git bisect bad 8d89835b0467b7e618c1c93603c1aff85a0c3c66
> # first bad commit: [8d89835b0467b7e618c1c93603c1aff85a0c3c66] PM: suspend: Do not pause cpuidle in the suspend-to-idle path
>
> What would you suggest to be done in this case?  Revert both commits?  Or would you prefer to have a fixup on top
> of that?

I would prefer to fix the problem on top of the current 5.16-rc.

Thanks!
