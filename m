Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647974D46D2
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 13:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiCJM13 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 07:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiCJM12 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 07:27:28 -0500
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90321480F3
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 04:26:27 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-2dc242a79beso55553607b3.8
        for <linux-acpi@vger.kernel.org>; Thu, 10 Mar 2022 04:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dPgacJQyBSRNHL2k5Y8l4uezQWWBCQQPm3zFV0o4HFY=;
        b=3KBZt+vFFQURn3nRWrio+RDacXO8Le6MT/1wQsvIlSGqjPRY3keWoC4cZRo4LWDmQJ
         eAv/PBOjiQWn17JOlmfuo78PCxApfhktGGixPDvCRTMzImkcAOcIR4t/M+gAXyrYxHRn
         gr9cxfUo4FvVZ4dwevbVMtjZ+XMqtrEkjDtb0B6NQNFSYUU8Jw7naJOmcOSsRY1GRblx
         BXt4+LAOb0ZXkyOjAGpo0/HKSX/friTtr2+xdKDUH8/Qps4+KGunM6weXtQwnNLv+Xwu
         C36SmVpRuDugoW80QrXHzdzSRJGOA3Isdu64sr3BxzP9G9CbZ/E+0Bw5+r/5RyOZH/Xe
         yJnw==
X-Gm-Message-State: AOAM531jIKP9Gw11oLGV6hPM0X8tLTu4PjF6XHtU/zT4XCwBXnj1pv/r
        w/WBLtsh/AnTbgvYkgy8QN794QghhifNrNjHpW3uhhe+YCk=
X-Google-Smtp-Source: ABdhPJwgOsFPQkEEMsCYySQkPlj5X70FsrWVBt0zBXQs4e/dxOSOlhsvEK5NqNkq2aJVmKWenBagYXGxQnhxqtFqPTg=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr3455602ywb.326.1646915186917; Thu, 10
 Mar 2022 04:26:26 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Mar 2022 13:26:16 +0100
Message-ID: <CAJZ5v0gE52NT=4kN4MkhV3Gx=M5CeMGVHOF0jgTXDb5WwAMs_Q@mail.gmail.com>
Subject: Please revert commit 4287509b4d21e34dc492 from 5.16.y
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.linux.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
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

Hi Greg & Sasha,

Commit 4287509b4d21e34dc492 that went into 5.16.y as a backport of
mainline commit dc0075ba7f38 ("ACPI: PM: s2idle: Cancel wakeup before
dispatching EC GPE") is causing trouble in 5.16.y, but 5.17-rc7
including the original commit is fine.

This is most likely due to some other changes that commit dc0075ba7f38
turns out to depend on which have not been backported, but because it
is not an essential fix (and it was backported, because it carried a
Fixes tag and not because it was marked for backporting), IMV it is
better to revert it from 5.16.y than to try to pull all of the
dependencies in (and risk missing any of them), so please do that.

Please see this thread:

https://lore.kernel.org/linux-pm/31b9d1cd-6a67-218b-4ada-12f72e6f00dc@redhat.com/

for reference.

Cheers!
