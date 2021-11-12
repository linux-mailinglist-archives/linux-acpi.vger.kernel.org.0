Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1444E422
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Nov 2021 10:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhKLJvy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Nov 2021 04:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhKLJvx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Nov 2021 04:51:53 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE2C061766
        for <linux-acpi@vger.kernel.org>; Fri, 12 Nov 2021 01:49:03 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id g14so35432748edz.2
        for <linux-acpi@vger.kernel.org>; Fri, 12 Nov 2021 01:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ryMDXG8u8nq91tliEM1jiAtuCmRdwdK2Akbl4Dq/sjs=;
        b=n9Qm+aV+4Yu8TxAjbYin/9i2l/3EdnZwMIMN4gkAyizd2vIPhIWhIg/OtBABlHViLr
         4VYWL8UjcUFuGMi+bSKQFVLXTRaK/plQILKFd2SzLFnglAa7sVMGVW+HcMMtxNKXvokK
         uHCDQheJqXWGaFlBwuoLRE8EBnA6IiY7bxjwZRGFCU7dxMU/n1IZhXU3tBFrAdZVbB8s
         oPLdqEBhvxqpJnu0S67u6vBruFBf00HjmVvnliH7K0YaXFuk86nnfkjwpB/J6eH3hinN
         c2VefwmUz9vZfVip8rRuzRjqHI40HLHe+dcbWqYutGCLiUegV5u9D3akWZzKyo1o/EuP
         uxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ryMDXG8u8nq91tliEM1jiAtuCmRdwdK2Akbl4Dq/sjs=;
        b=q6l7i95ooo9019ztF+TDOg46ZMFgqx7KNHFL8T8JOmuYWMzte5l3XMOoTFRoAPca/T
         BvnP2XlStt5+txBdLlyEG27KKV2nKbBYSno63qWtHiUqnHyK/QfWoPjuAm/K9JsHbcFA
         Rxu2sieOTC0mr+DzGhgol7CYjEy8ckpfVD2CMxEtpFYaL+TBMMYObONlKIJHULjl4ChR
         9/LmmGKdTs14lbkyEoZRx7zSO+J9hWIFGFBpmc33mJfDqJzlX5P6YC32cId5qhF6IMqx
         zgGJuHluJEzgGUmHrm8VrcUL1zqxrczrEFzxcKO016NUX8cPco9h0/u9fvaaoonvWx3I
         tg7A==
X-Gm-Message-State: AOAM532A8gC9NBS0jiCGK4bnUmQYZ9Nzy0pQBlHgcQbVBXeSi4pE8LET
        gLNAPUGkK3wd+pnmORGXV+8BTyvmFJIFR8fx/Jk=
X-Google-Smtp-Source: ABdhPJy5SIunUzCDU/n5vNiQTKsYeQvEdvRahkJcQUkBg4+Z4Sf5RtOSjd9WPWGMKL9KkiOH5jhpjC4FFE8NdUbKBbU=
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr18653536ejc.336.1636710541853;
 Fri, 12 Nov 2021 01:49:01 -0800 (PST)
MIME-Version: 1.0
Reply-To: mrmahammedmamoud@gmail.com
Sender: suzanqaseemzz@gmail.com
Received: by 2002:a17:906:9b87:0:0:0:0 with HTTP; Fri, 12 Nov 2021 01:49:01
 -0800 (PST)
From:   =?UTF-8?Q?Mr_Mahammed=C2=A0Mamoud?= <mr.mahammedmamoud0@gmail.com>
Date:   Fri, 12 Nov 2021 01:49:01 -0800
X-Google-Sender-Auth: wVLMJkGnWdovyj2Mkr5WUSFnAEY
Message-ID: <CAJCaUWsCidoNyO+GhbDChAXsWrzcgdytgrS-MRtv2Mo2w2YkUQ@mail.gmail.com>
Subject: Von: Herr Mohammed,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

 Guten Tag,

Ich bin Herr Mahammed Mamoud, Account Manager bei einer Investmentbank
hier in Burkina Faso. In meiner Firma wurde ein Wechselkonto von einem
langj=C3=A4hrigen Kunden unserer Bank er=C3=B6ffnet. Ich habe die M=C3=B6gl=
ichkeit,
den Restfonds (15,8 Millionen US-Dollar) f=C3=BCnfzehn Millionen
achthunderttausend US-Dollar zu =C3=BCberweisen.

Ich m=C3=B6chte dieses Geld investieren und Sie unserer Bank f=C3=BCr diese=
s
Gesch=C3=A4ft vorstellen, und dies wird im Rahmen einer legitimen
Vereinbarung durchgef=C3=BChrt, die uns vor jeglichen Gesetzesverst=C3=B6=
=C3=9Fen
sch=C3=BCtzt. Wir teilen den Fonds zu 40% f=C3=BCr Sie, 50% f=C3=BCr mich u=
nd 10% f=C3=BCr
die Gr=C3=BCndung einer Stiftung f=C3=BCr die armen Kinder in Ihrem Land. W=
enn
Sie wirklich an meinem Vorschlag interessiert sind, werden Ihnen
weitere Details der Geld=C3=BCberweisung mitgeteilt.

Dein,
Herr Mahammed Mamoud.
