Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4052C717
	for <lists+linux-acpi@lfdr.de>; Thu, 19 May 2022 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiERW55 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 18:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiERW4k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 18:56:40 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C03BFB
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 15:56:38 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id a3so6155363ybg.5
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2022 15:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=P7btzPR/Vle5l5s7elmWUZ9LbIEztS0Dc/XWoKmbneMBSsyDUMsuJq4Ylhmt8/MC5e
         pJc+Ha/GSmxPyR+JdYHJoUFxOoYk9ieaAqtMS8Ad/Z8FFnk0SBrbeexgNWCx1mNra3gM
         hGv2lOHT2ygyJecm9zs3u60rq/z5V46Mv149dQsnD7sOkOVJHrEcjIOxJdOJZzvp2cLC
         b4vuntUJt9jllUw+dktv9HiMdX4t/0QcdotI8yofG7S/s1xzgxKTaTrGFOqfrHiuZaW8
         DOvgPDu3PJm+EZZi2hyjzVQUQQjR4DzqQE3uk3PxTqI0Z4GbZin4x77hgi0oOTRWiqb1
         GaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=IqE2O2w9RUiR6000QxmP4Jh7gYDvV72HLvG82aKEgZE+U7AJK/clrdl2jaCWz0lEbt
         KOFqEdYmzEJxfmSN7pHsjidMTLCOgczZ0MvK9DDEDbm2cTCIRifZ4/gUNtOLDC44HBxU
         AQkzyUxoqtXc+nEOC07gON2oUtQESSk932FMMDcXEblk7ClOo/2skn1WuCrH7hOKKTVn
         vstqZ3S/6uL52FIUwml9879PosN8gfGZwHk28YH/YUnErFe5jN/aqBGIvecGE38yFHIN
         rjpEtUo0FywANUml3WwzrUhVYt15B2+psAP9G8ozcEZOtC/gY+8IG1ZJLedMjHuBrgBL
         gbQg==
X-Gm-Message-State: AOAM5317y9xBiD5C20FRAwEZxVbbE//JhFDg8MSEF4gK+O8tr8c5wrBR
        L19BlzSvU1biBNIXhM7PkzoOArX1m+lg2JHoPSo=
X-Google-Smtp-Source: ABdhPJwY8YOdHYUX96JiSxTq5wchI8FXYyVWKhCwVLyfcYrHLYm89em2SVFzx0M4tBmQDsZA/tugAFPK0TzA5I8AB4Y=
X-Received: by 2002:a25:3746:0:b0:64c:4ab2:8277 with SMTP id
 e67-20020a253746000000b0064c4ab28277mr1756177yba.631.1652914598250; Wed, 18
 May 2022 15:56:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7143:0:0:0:0 with HTTP; Wed, 18 May 2022 15:56:37
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <weboutloock4@gmail.com>
Date:   Thu, 19 May 2022 06:56:37 +0800
Message-ID: <CAE2_YrBTNWLgT7Gwd_cY5oXmwwHz8Y2=Hv+EONJDgQpe8gV-5w@mail.gmail.com>
Subject: engage
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4867]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [weboutloock4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [weboutloock4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Can I engage your services?
