Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F95BF012
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiITW1e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Sep 2022 18:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiITW1c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Sep 2022 18:27:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0000C5AA3A
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2022 15:27:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so6238757lfb.6
        for <linux-acpi@vger.kernel.org>; Tue, 20 Sep 2022 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=j6nWtPnYLSsHSEU2Fh7pNCRBK7RTfSBCh+IN0V+FE4w=;
        b=GObmHjCH5PfJE93eI7mjNmTvkOaFISqWsuF3ErT4wNWyK9Tfjh8ZRavDACSfigzna1
         k+7/tDEaSf9qg7eKDrWSlFzLZVqbLNQ8q0yKj+FHVKRscPFV8Q+ZBxxenb2h9CKzIZbJ
         y0TI9ulubBQ57LySH8IGlvhWi6wuCECQeiXXGpWst0Ca0EoHMuzsC3glnVKnIDzjh4dn
         p38NRbXZ4wBnGGP8hzYftGLWnQBjcQvsd9K7VbsHMQ1pe2E3NdfEEe7YMYrcOzV49JwO
         vdgBnqP4yF5eg4Zn9P9GhPxZQ5ONSolONvenQvZoSNXdz6pQzVWxjeoCmWqffztvLmE5
         XnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=j6nWtPnYLSsHSEU2Fh7pNCRBK7RTfSBCh+IN0V+FE4w=;
        b=HlI1Gqzd+I7i6uKZB2IzqhoiU147KqGmzCkEKiUs8HYr5TBpx3u7uzYYkqo1mmRUTv
         tIkcgvVIYLf56fdR+QbSilzSmc+DAPz+/eKjSXdjkgTZojug+QLqi/ybxNWcykhjWOlS
         a3wozHNvkzKQCAk4Kn9EyGkjHWLPlMdwt7KRa/KGsmJsPEKmqUQyOYUIUFo1m/KgR9p/
         wRU/EojoHPPvCuLglTrP+91QUDrbuBhG5LpAuE74YqvNg5PidOopHawiYOhu8+FLgae6
         UKQm0ghSQgS/vUsvhFR8bWYdhwNbsuu1mCxFg0iWDMsfjRl2TtnV8DXJLWb1ienMyCbV
         wPUQ==
X-Gm-Message-State: ACrzQf0W5Suz9j9nEwC1gLVS0CZ2lQ40RQ07ajkol19tomV2BiNBKuXI
        yjJxus1FH2hyJkjiIKr1sOalK31pUOuK3NV6Sdw=
X-Google-Smtp-Source: AMsMyM5x3pD4cPugUYdj2uZ9DYeud8LgV1lGGDQ3/CJ3sRFnwDVesgT0LS6Lo6ggyXOu9lq1HeB2TW7qXOPyO8MPpSk=
X-Received: by 2002:a19:9157:0:b0:496:8bd6:a594 with SMTP id
 y23-20020a199157000000b004968bd6a594mr9241739lfj.314.1663712850075; Tue, 20
 Sep 2022 15:27:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7344:0:b0:1e7:bb66:ef7c with HTTP; Tue, 20 Sep 2022
 15:27:29 -0700 (PDT)
Reply-To: te463602@gmail.com
From:   "Mr. Yakubu Abubakar," <yakubuabubakar1884@gmail.com>
Date:   Tue, 20 Sep 2022 15:27:29 -0700
Message-ID: <CANt38euQjWkpreE02eH1F6m6WqCQmUCQzJpauKNHu6kLdNSduw@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yakubuabubakar1884[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yakubuabubakar1884[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [te463602[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-- 
Greetings,
The Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

My regards,
Dr. Yakubu Abubakar..
