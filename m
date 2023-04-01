Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE66D2C13
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Apr 2023 02:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjDAA0N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Mar 2023 20:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjDAA0M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Mar 2023 20:26:12 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEEB1D847
        for <linux-acpi@vger.kernel.org>; Fri, 31 Mar 2023 17:26:11 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h11so12370308ild.11
        for <linux-acpi@vger.kernel.org>; Fri, 31 Mar 2023 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680308771;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mk2nPyPDHF2nSoHYsdcPx4I1t1gE9idID2faOY4LJU=;
        b=m0ajyKWbiBsQi+yyaFeDz/LekS7o8eGnHuyLrqrWzF0DfDtB9TLUsx+koS0AjcxEl9
         n6JTDwucfctUVgPNSLqFa4LqbhZaSdqDYQTPHA9GxPgJcFRoL4ArKup34dd8wQz832Wu
         2isTIOo6nS/a0jcSJZbAVM+7vvjDJV+HXPXz8Vo5j538pJDsgWCCOANzDsA3ex0Fla8B
         rCRipNZkVZRX1K2FsMNhrWLFL8cwJhKaS5VgU2fRyZAVPtF88SV+maYua6tIqXYnW/8k
         iRyFeXM46PkemDKdV5BjQ1fdYL3uk1Z/rHU3c/RjxyjVpmaGB0f97v5AubCz0Ct6123w
         N+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680308771;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mk2nPyPDHF2nSoHYsdcPx4I1t1gE9idID2faOY4LJU=;
        b=dLBmy8+ve4RE4hlujETE0DylDEk3+kFu7VJVaCn+fxIAu+jFzHYdsWy56Sxkyb7nC+
         vbi+MMQ80wUmc2BtEtTTjULFRxS6FIBSwJn+NaH4P96IllWktXk4ict+ETlJGC5Xkrdb
         8oJW97v0T4t/i7bv0UeqgH+4dLrW6jG4p8tVIhJkq7R27VZdUwKXr/nGM13NKk6vq0PZ
         nNRCcFWsT7KdA32uLXCJyvtCilz0yUG6hRZkrQXlZpIFKZ7MpGveFKwx/CxSGeR4cpbW
         YZOfkm12z9Tsg8eZRZ1f0UDrOZ7SOuCPl4LegvS5zIJB2JzQWQAgohlP7Oeu/qAAvuSX
         b4Cw==
X-Gm-Message-State: AAQBX9ckzrMC+w0yIY41ver3H+p5QrEXt2l7L4vSZ1vZfw6br/UUi0iK
        k21lHlYFlLYItgb7eXFHO/7N9aCLN7UpjmT+AR0=
X-Google-Smtp-Source: AKy350aUUatv9USo+GLWE0R5Db4InEQ8FHyjW5YFVynnQRkX0fZbVcGyKJTRBVnZ/jP/LD9w0MOP2MoDjxBnl/ijkvE=
X-Received: by 2002:a92:cda3:0:b0:326:3f06:a0d7 with SMTP id
 g3-20020a92cda3000000b003263f06a0d7mr3672994ild.0.1680308770905; Fri, 31 Mar
 2023 17:26:10 -0700 (PDT)
MIME-Version: 1.0
Sender: samanpyabalo@gmail.com
Received: by 2002:a02:cf2d:0:b0:404:a526:7a9a with HTTP; Fri, 31 Mar 2023
 17:26:10 -0700 (PDT)
From:   Miss Katie <Katiehiggins302@gmail.com>
Date:   Sat, 1 Apr 2023 00:26:10 +0000
X-Google-Sender-Auth: WuRBnijy9fCcJAq2-UPWB2Q3aDM
Message-ID: <CAMbVUx65en446=mFMvR9m6P7orJE_Hs+Evm3ud1dZeSzmLDCmw@mail.gmail.com>
Subject: Re: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hej,

Modtog du min tidligere besked? Jeg kontaktede dig f=C3=B8r, men beskeden
kom ikke tilbage, s=C3=A5 jeg besluttede at skrive igen. Bekr=C3=A6ft venli=
gst,
om du modtager dette, s=C3=A5 jeg kan forts=C3=A6tte,

venter p=C3=A5 dit svar.

Med venlig hilsen
Fr=C3=B8ken Katie
