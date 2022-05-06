Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D944551DDB2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 18:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443818AbiEFQkt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443838AbiEFQkr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 12:40:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1FE60D91
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 09:37:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g6so15495134ejw.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 May 2022 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=A3XzKJQE+uB/LOKtSYSm/Y3Eg9GsdAVtLOA/avMcmetoiIyN1PB1Ic8KNDcW7C/amb
         KXe5UUv5juRd7TAk7RYRLsiFdG/FFTc06xIOlwKTogSJlep7AfCbzIgVCBXd4gsQg24J
         JLcR+XtLd9+I2AputYqEx9N+K5sPislwXzSJZGHxBtaUV2oA188ePJidksErlRvKNrO1
         6WTeu96HtcY3hOx6dzs2d/nIjA9pcyDWH7ePPqmGIJOR4uRGECu89p6U9Pla8gJJBUjG
         7uVxuYBeycpmnZZl+HNXINH37dhl5QEloF8/ow3FYTz0zbYSBxi4T8ufogGAfb11+9ly
         gZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=O5RT5ptSrGmqKXbhUd7bvOSC0sAt/hNrDH2sA3S0r3Aws0YJq+GAkrlVESDluVZKjs
         ClZkzExOy+9943xOT5hSYWmP7Jybt8wDvZ7hR/DiXkwiuIMfP2X6S36ez3CjIu/xr8sk
         dbD+G+L38ss9PL4F0B2YR5uWnr3YlYxK+saS0DzmdQEBDZPakACkWQblf97sE53fShl4
         RckLT77VgVeOnw2niy3fHt+kZTrP0wOIsnhMP1neMgn4A3mvrOaRSqGjoqYQ83NYTxAK
         myevhLha+AhPLtDJMXKDLQx96gmJcP5t+uwrIovZEB7Tc13p71n6eM2cOH08zDINa7/p
         phkg==
X-Gm-Message-State: AOAM5330XDJU0F9oNCiG42c4XndrQfihyHryDwVQJlgwPuU/W5p9l4/E
        fndYHTqO9by/SCKATH0ejV+8/dQVJHqWnbibmY0=
X-Google-Smtp-Source: ABdhPJwnRIy56mAjP8E6vkcVQOslbQKg1iMV1wbbVMtQkIyGOnWkQJwDS1+Ffo/0PywsNDqpQmyHDHgRqFGluXuZTFI=
X-Received: by 2002:a17:906:9b89:b0:6da:ac6b:e785 with SMTP id
 dd9-20020a1709069b8900b006daac6be785mr3732287ejc.295.1651855022480; Fri, 06
 May 2022 09:37:02 -0700 (PDT)
MIME-Version: 1.0
Sender: amoudiatchakoura@gmail.com
Received: by 2002:ab4:a56a:0:0:0:0:0 with HTTP; Fri, 6 May 2022 09:37:02 -0700 (PDT)
From:   "Capt.Sherri" <sherrigallagher409@gmail.com>
Date:   Fri, 6 May 2022 16:37:02 +0000
X-Google-Sender-Auth: eRFCrsgwDsp4aIlOj3SB1l1t3e4
Message-ID: <CAGZPmGEgQWq+VO-7NyMLwoVq3WtVOdt=W34aLXQLH7q_b8w16A@mail.gmail.com>
Subject: Re: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heS9oOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
