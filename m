Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B15372CA3
	for <lists+linux-acpi@lfdr.de>; Tue,  4 May 2021 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhEDPBq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 May 2021 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhEDPBq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 May 2021 11:01:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFCEC06174A
        for <linux-acpi@vger.kernel.org>; Tue,  4 May 2021 08:00:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f24so13664548ejc.6
        for <linux-acpi@vger.kernel.org>; Tue, 04 May 2021 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mA+7flTfvFD+Y2LLEaQlR8RXQa0DdDmjTntjiGWz1oI=;
        b=TZWmdMbtjew4xhiSW93zlbg/ydnJS2lHqww7kuN69n9omCbt1nqaQGPmuHWROB/ZA+
         KU9w/f0hQGSxRQ2yQu5OaQjw9xUqxrwYre7xuiDx6S3mN06WB8LwkuKZWvDeyJkfMoOL
         3Rlig8Pbe+2FVCExYZyGDr2cBcO0HLBSEy8PTqTC6qbPkga9XtOzW2ov1cqWIdZCzxkn
         0NdjK93+1Dy/SPhEvhj5j+3/1GR4nmVMBD32Z1wSAd2EyXx8wWI8F8ORwa8mi7GhIDd6
         2GY9xm+I5l9Y+4FDGiOJglfjEpSoOUuBC0515FMx3xxBmPgyLkyiyKfgs4JGASj/9NZp
         pq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mA+7flTfvFD+Y2LLEaQlR8RXQa0DdDmjTntjiGWz1oI=;
        b=lDvVtjJCj9LlBC5dFOlvqexhWgdgHny8abtsvS3ZfppQy1+/6N3ZOdD/5UfZxCf4xO
         D6Qtzt3l2JI9gAIHaj91taAHZprkIQ2+Le3foUQ8dqoZTiX0qYL5YMTke9sQ7n2Npj1A
         Bz1WX5/9pc7T1S5BQ+Fm7Jw9/i5zl+ZFDKM1xi9l9ZXdS3ZcxdWQf5INwDeMGKTe8O4c
         e0S/DR8lmOIQZkP6cWE4P9FWZaV3dwgbhEi/Q7IsIeCexAgKerQsDgcTWTXSIUT3whjZ
         ijJyXp5T9CmUyQ2veMCzAc3NB0YVGgEuOI+WNS5+dPCxPg1A5U1/qRGBRUnw/JXQu4ys
         ZrrA==
X-Gm-Message-State: AOAM532JC5ngAobb+NOBswZG2S1Vdo4h3NLmEiBUAPrGBKkVeN2xmeYx
        CIfX12G40axa9wPwor/u9kRSsOoYaBef/xi3+j0=
X-Google-Smtp-Source: ABdhPJxr37QY8f/Oi3o1c2rmwDEndoo5kGIc4tsTktR2qgWHDTD7CaVNyrC9kA0suzEHsEwZ/ufCfjVriBnfy5tSq2w=
X-Received: by 2002:a17:906:63d2:: with SMTP id u18mr14945579ejk.186.1620140450060;
 Tue, 04 May 2021 08:00:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:35d0:0:0:0:0:0 with HTTP; Tue, 4 May 2021 08:00:49 -0700 (PDT)
Reply-To: lia2ahil2@gmail.com
From:   lia ahil <jeanlamp6@gmail.com>
Date:   Tue, 4 May 2021 17:00:49 +0200
Message-ID: <CAJA2FWQ+bv0DMPRZrMPWRiT1Mmxr9ZNNsxpdCx9dLhUC5t1CGg@mail.gmail.com>
Subject: Guten Abend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Guten Abend,

Mein Name ist Frau Lia Ahil und ich schreibe Ihnen, um zu best=C3=A4tigen,
ob Sie meine vorherige Mail erhalten haben.

Hast du meine Nachricht erhalten?,
Frau lia,
