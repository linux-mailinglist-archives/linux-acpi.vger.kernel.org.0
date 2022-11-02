Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7889C616955
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Nov 2022 17:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiKBQk7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Nov 2022 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiKBQkq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Nov 2022 12:40:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7CD2D1EB
        for <linux-acpi@vger.kernel.org>; Wed,  2 Nov 2022 09:35:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g7so29151597lfv.5
        for <linux-acpi@vger.kernel.org>; Wed, 02 Nov 2022 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtinHIir+rkzKtWy1avfy7A9kIdr1heNBplzC+5ZytA=;
        b=WGsVNO277WoOkdsIBNqslST1kW3C9sWXtShzQHLJV66Ys9qlawLrkiBHzqWdMgE+F6
         RMVsMe0tne3g2CUkhEfZnVPrqwa1HFXwcsyiea08ZHfELwPpuKnob3u25x0B65yRot2i
         HBMRh3cCZfLjlMYdbhHwAMn39oe2F5FLbDdOhK+h/odCNzqXHZ/BogZw5hwL5aE2NPC1
         mEqDaOjGEZaY0BNbW03MxdH6fR7ZQNoXALgW5JmOJPtUAOrbUAfbeJEpgHGuC4otn/I2
         /HXsEsXm/8AesXyiiWLz38KKy9/U7zQVzsD/qUl4pAbXr/YiJXMX5nG5JXSuM9VBeHs7
         dx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtinHIir+rkzKtWy1avfy7A9kIdr1heNBplzC+5ZytA=;
        b=NetqR0BhbRgA+eYQYODBWly90NddowF++IbjTk5GYDRsOaKwDHGXYcRPd68MqhhoO+
         urDtvhSLbxm6wTt3qKUCoOUIvaj74VCkURAUo0cjjspmPvv4GL6USAZgiJlUZBEZciu8
         9xU8PHWu74xhsp0QBrTk5AkG/Wfnk6FbS06FO+QJes83RUtG/Ky1FANJh8EXhgrnLlIT
         mJAblKQekME+fePCDfyCEeDWrCp4NX/RF/FhPzmhPl6LsMGwEkuXvNLBv1i3ybdOewM4
         xmGGWfX9BHmt98ejhbJa2fhEfSOeIkV+1DAjQIqbw2eUH8HOH/wk+fNf6BO4gnW56TVs
         LIGg==
X-Gm-Message-State: ACrzQf0z9l/CRhCwKbrRfMLEDXCqD6OR3XUhJrpIqNNzMnMLGT399k4J
        TK6o7uxipy+CKxTYmJmxQlFeXbYRqkW1u/VNk0LXVp0=
X-Google-Smtp-Source: AMsMyM4cE/hwcHbQ2ffBiOq2Bq9Oicvlc6pOTHZJEb3OpVkEBUEu9glieIJeNhwKjdtkTI5Tkp7xdjKZ8ckOuuVREwY=
X-Received: by 2002:ac2:4a9e:0:b0:4b1:8173:61c9 with SMTP id
 l30-20020ac24a9e000000b004b1817361c9mr108240lfp.296.1667406932799; Wed, 02
 Nov 2022 09:35:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylamanthey612@gmail.com
Sender: kkperim@gmail.com
Received: by 2002:a05:651c:1948:0:0:0:0 with HTTP; Wed, 2 Nov 2022 09:35:31
 -0700 (PDT)
From:   kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Wed, 2 Nov 2022 16:35:31 +0000
X-Google-Sender-Auth: WbrjPLsKnTJ5uEt0nn-xUq5NxZw
Message-ID: <CAGCYFRXSQBFhA3-cb9iksFN-Kkur=+i75MrYiRX83Yr102HHSQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello how are you? I trust you are OK. please check and reply my
previous emails.
