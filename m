Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D9F7056B6
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 21:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjEPTFf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 15:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEPTFe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 15:05:34 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C678E1BF6
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 12:05:33 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3943fdc59f9so18437b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263933; x=1686855933;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIuacTUe55V68yxCoo7ary9vLzT4+1nPwynRvBBZauw=;
        b=oEHLMhvTQqeAFA86uX2W003QQmuECmHBYJqRL8c3XcqEC7zkj9yGnTFKamtqebagqq
         bEooOO3+liB2/lDq+k97iV5LFvH7g/3N2dpcAd+siv+BLfu0iK5au9lm5Teld9qX/qt+
         VVjGKDqBhgpAYdm33HlBA26yUxgEDNhGtFy5u1x42AUXnAQ6PuAo3TiEwOUO8dOGSfEK
         o/nE33rpV/VeQmIP7c/V03p0hPRbpw+2k5njpyzvfYl1OdisTz6KPuUNZJw5hnTzMZxw
         7H7QrQPxDLLGUYpnjckv4+bOhUCAVGqZBCqzJZ58Qs3sOUlRwepSlCxiG9QxWiwzIhLS
         t14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263933; x=1686855933;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIuacTUe55V68yxCoo7ary9vLzT4+1nPwynRvBBZauw=;
        b=HZS8YcHp0XWTFZkACDxWbHFID+RrOS/j8CNXx0zIpQ0Us/Tz8MDiHzjl0zmjRIPpDg
         f5IjloHgcvx8Csx7JbticlrPLt3S+oDrRArXWVO0ceGbppdNLWZb0ZP/3RAnQ8DH05tP
         tf7mRJcbvqPEep8f1yyudcNx/vpbQrAD3Pzn+1gBD2sfgM2MJzHMhHbs9EwUb1SWHODv
         9nYmIq+SzErjV6j2OnfN7V7niebaG5z4kjAQrjIZEC+p6IkbDmodnuKQbjOFCqs8I8dw
         7SE9l66j1wAtGIhN4enB15qsCz66nRLdUBpKHzPGKJ3cxKG4P2Lwzlpy+Yc2CMCmzqDZ
         STrA==
X-Gm-Message-State: AC+VfDwzghMkNMttrjUcl6lRkpyk7q7Mz320z9MyudlhfentaZIFHIJv
        ZB3TUpIrWJk6RECNHcYmzOH/TGgTIVWIN8Y/bTs=
X-Google-Smtp-Source: ACHHUZ5tQWLyfZ6Wv//YRYQYtHum1hnvAuOmDMTdFkWiCRfuZKhxkoUHBM5ibRWeRSeSJI/ykbZvC50e7eEQxIATxQE=
X-Received: by 2002:a54:4391:0:b0:395:f3ee:d191 with SMTP id
 u17-20020a544391000000b00395f3eed191mr4974011oiv.23.1684263933058; Tue, 16
 May 2023 12:05:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6841:4da3:b0:128e:4a83:b402 with HTTP; Tue, 16 May 2023
 12:05:32 -0700 (PDT)
Reply-To: sharharshalom@gmail.com
From:   Shahar shalom <shalomshahar47@gmail.com>
Date:   Tue, 16 May 2023 19:05:32 +0000
Message-ID: <CADDwMLLm+-7GJ1zBFSX8NMgOv8TmVXrdTeG_z6DqBGqScYgYfg@mail.gmail.com>
Subject: =?UTF-8?B?5YaN5Lya?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

LS0gDQrkuIrlkajmn5DkuKrml7blgJnlr4TkuobkuIDlsIHpgq7ku7bnu5nkvaDvvIzmnJ/mnJsN
CuaUtuWIsOS9oOeahOWbnuS/oe+8jOS9huS7pOaIkeaDiuiutueahOaYr+S9oOS7juadpeayoeac
iei0ueW/g+WbnuWkjeOAgg0K6K+35Zue5aSN6L+b5LiA5q2l55qE6Kej6YeK44CCDQoNCuiCg+eE
tu+8jA0K5rKZ5ZOI5bCU5bmz5a6JDQo=
