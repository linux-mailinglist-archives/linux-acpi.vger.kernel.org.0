Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60F70A0A7
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjESUgT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 16:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjESUgS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 16:36:18 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0D10F
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 13:36:17 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-75791a035b8so194009285a.3
        for <linux-acpi@vger.kernel.org>; Fri, 19 May 2023 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684528576; x=1687120576;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=iKPz9Oh4/TvVutVjYTfPi0mjubOCm5vM4CVbTGjh1CEUB63GubzRmFCVaqX3GyvjSH
         UvJlkmD4v1juCbNVwQ3OIs6PDGP7Jf8uqyXqRinbquXuvulf9PbLIoMKagLcY3edyWRo
         XDQlSVsRSXCOSnkrEt9igXA5SXejdTxCR1fUZ1gP8KSIS/7tsrxUUVtQ7VJy6pmjEzRL
         uRO4ZT4zlnvL9MpYySpXjW3JwOPLE6/og/rMjLYZCkQGv/7YL5nIqFUOMFxkbvL6u9pN
         gueIhAcEq8omC2de4/PPfLI+selElP2mz6un1jXu2QmxZiEPiQ++7JKkD9AJMR3vsOMf
         vkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684528576; x=1687120576;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=PjOeyzqQrJpBuBfmXDD1HjJC1ZuNfU2s8Ld3OQLuR3ddvRYgvawKAjj9Gignrs0or7
         /mVNhQLVTzORhzIkxRcRGOAWuakZ46NAcn3OYWEt6IQ5mAeXMincqyoqWBFYBFkZt2A8
         bulNBteXx8V8GCYXFHcE24w6AuhUedCXWoGpoq0HsCWkiTY7CV2a0UEBoL9JZIUUSb96
         vjFgsL/r1F3BAyh+1aQ1ehCCpdVcUatmNQPc5AhCgVzw9M+K2clxCwUosPdsEqvepBAL
         qCNtk4ALALPU9ppkSbPrjbCLWuseSP1N2Le7vL8ZusGncgbgb10bq9XYQOHChMEcJJac
         4JKg==
X-Gm-Message-State: AC+VfDzypjDJDABjOxd9g6YjhprQnb49KYJvzVs8+zfeKO8BvzDmMpNy
        tv+X7LawvT+sJGGv6mREQSo4vf2RpUdM+SOh9sI=
X-Google-Smtp-Source: ACHHUZ4oVWzrM2Cl1CQkqiQLJ1xIhyBwUZcbcH94LKkZdYasH6Ds0Jf0Yom27k6E9aoxU7l5KEU+PRUAWlhkwCoUc1U=
X-Received: by 2002:a05:6214:c8d:b0:5ca:83ed:12be with SMTP id
 r13-20020a0562140c8d00b005ca83ed12bemr6007898qvr.21.1684528576436; Fri, 19
 May 2023 13:36:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f205:0:b0:623:7c92:8385 with HTTP; Fri, 19 May 2023
 13:36:16 -0700 (PDT)
Reply-To: regionalmanager.mariam@hotmail.com
From:   Mariam Kouame <mariamkouame1993@gmail.com>
Date:   Fri, 19 May 2023 13:36:16 -0700
Message-ID: <CAJF_a36r4b6Dr8-hkX=x2WOwmphyEtxVNkc+uRSvO4CLqcW6AA@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame
