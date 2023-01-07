Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A7660B3F
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jan 2023 02:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjAGBHs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Jan 2023 20:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAGBHr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Jan 2023 20:07:47 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11E551C6
        for <linux-acpi@vger.kernel.org>; Fri,  6 Jan 2023 17:07:46 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id r130so2487020oih.2
        for <linux-acpi@vger.kernel.org>; Fri, 06 Jan 2023 17:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=nmsmQMZvdhIgS6ecZLly4Ad7eZ8sM5Lr0ptLXa5TCdPxGsa7ao28nDJNkuukCByZH5
         mhNyXs3eW1Ca80UK9WA6ojsNf8M50V9R07isr7abNe1V9JqdVigD+67J0fGcu1QptQRp
         1B/BO7V9i6dzuTLoD8jI1Fs6V209NfyDzVGpLrmDuJw1liwGo8aT/TZAKLBTUg8Ll9iz
         gg2FQTYQ6e98fsMbLwjU+tM7Ds0SJEbX7s8JnLr/BLVi5aGbBF7Yg3AYMUAyiTUs5IQh
         egtjsnjyfTCnSUwipndbp/Fkd2WnN21jsUcg6GK1jQ8Co47u+mV+i4kQWRsDdTRXxO4k
         XntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=UBsusnmiGdmV0ElW7i85+T1TM3uX0GJVG/x3GBWYrsoeY2wcOOtj3Hzk8/r1IFn63K
         L83Rgw/V13dxQ2vIIYhgwBnmiMf59gCUzJEbf6s+hC8lt0eHtjAAusr5DSZ6mq7mkZiI
         VmzzRh17inggk+fNgG7Wc1vX57lElsL2ThcRwr/JwO2h/7lCafx0H+L6NVE8jQiu7MQP
         dpXtme54RonEjKleznSTLhkmnXxlu/lVeJcoXpSrkXHKhtMWb2Kg1VQcXxet7LDlqR19
         W0c4fCSV6Dsjof1IrVw56yHLajoim0UU3Lt4g9sg1yVaraNjjizZwRVxDP0494Xr6ACE
         ZQhg==
X-Gm-Message-State: AFqh2kon8CDeDi+X364jOlcf4TeIhn7QNfEPiSSCg+LsVODix1oditEi
        8ALNvVDsZbdToC/hPej4U4oISlJdi+FFfWojb7w=
X-Google-Smtp-Source: AMrXdXsRh6PRYoKr0jXpM6mjlzta2om81nvqgw58fUKsI8WKdwiVR5llClso3UyL6VUxKExk0JKBlqTf4VATJIjbX6k=
X-Received: by 2002:aca:1b0a:0:b0:354:7fcd:4e27 with SMTP id
 b10-20020aca1b0a000000b003547fcd4e27mr2936955oib.239.1673053666059; Fri, 06
 Jan 2023 17:07:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6808:2387:0:0:0:0 with HTTP; Fri, 6 Jan 2023 17:07:45
 -0800 (PST)
Reply-To: jamesaissy13@gmail.com
From:   James AISSY <samueltia200@gmail.com>
Date:   Fri, 6 Jan 2023 17:07:45 -0800
Message-ID: <CAOD2y7nQAbfT-V-Bx9JaeknDim5e7QQ31TiK3Wo8QUvq-CuJqg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello My Dear,

I hope this message finds you in good Health.

My name is Mr. James AISSY. I am looking for a partner who is willing to
team up with me for potential investment opportunities. I shall provide the
FUND for the investment, and upon your acknowledgment of receiving this
Message I will therefore enlighten you with the Full Details of my
investment proposal.

I'm awaiting your Response.

My regards,
Mr. James AISSY.
