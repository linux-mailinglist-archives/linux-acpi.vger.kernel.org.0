Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68A517BA0B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 11:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFKSz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Mar 2020 05:18:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40162 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFKSz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2020 05:18:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id j80so2025201oih.7
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2020 02:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/P9ncvx+VEUMrpqNZpinMs8EiuqcVr5r7uKIGRLhXTM=;
        b=ZR8EwZjrhRF8Ta2KP4J6/9DbhubduG1kmsAQ9cbBK3X32H/mIp9QZ30547GJ20Y8Jj
         T8ZwKQJ2ZqyoJF8xMYjcpV3IAugG4n+0jCquBoTLpkHD12g9cnRh7pDXYzm3sMAce+Yr
         IwhTvuaLXOGqHcFHaTBrj+nHVOZdGltkvTCqMRsDM7dd0TFVTGbNcz7+26lJars3iG7b
         f37Dgb2VcoXZpObLHcIczcZ8ZDaC5+UYhJwkez9Ldof44W/AAAxDYqHUaDumk0JT0Dl+
         Dd/Qj7s3uKSjXfHEHCOXQ+rZl2SUfsfhjsCgPZcNohwnu5uAVispCQClZCSHml1qRx0j
         aw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/P9ncvx+VEUMrpqNZpinMs8EiuqcVr5r7uKIGRLhXTM=;
        b=Uq8l6ulPDxtI7i5y9/lCudDyMCQw/Y3HEMyk+QMC0e9tKm69xo2mNpmG/TwJI3papJ
         aGHCIRuQyfHmX2FCtV+GNtAi5YdLDvQzM9+Bmiab8j/JxLAEJ+1Rgi8pWO1ADeIJO8Vb
         02Xhx0jb5PVX5mdIs75Q5o+OtgFfGgYZX8KrrQ86Gwsz6SLPaq2NTBJC7qQ9V1bD7Vlu
         LFaq/+dvVjVZCCURuLp1QYaLty6Md/MORMAQQnwpUqicvYkqOsnJg5DskEezll0ooTh0
         t8V6Qktn0jXTJfHN9qLXjL32NrmJ4kkND/i0Q7i70IUtwLihVquBu11e8Bsxm1tDbpts
         ci3A==
X-Gm-Message-State: ANhLgQ1xlovDrgZxP9RcK4LGM7AZL/VhJG0xDZyXV3dJkthvlilH8sg+
        tN04pLJ1McReLYpRqlUsaw30ypFODwZWi1aw9lU=
X-Google-Smtp-Source: ADFU+vtVl8OPWjsw6mHZ71sZzvO/ABnvsM1P6Px1IIoCLuKKMra+FYjA1DFDDsj7Hrb5DtHO6h5LCvs7NAXNCYV+/TI=
X-Received: by 2002:aca:5757:: with SMTP id l84mr2126034oib.56.1583489934457;
 Fri, 06 Mar 2020 02:18:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:4e81:0:0:0:0:0 with HTTP; Fri, 6 Mar 2020 02:18:53 -0800 (PST)
Reply-To: robertandersonhappy1@gmail.com
From:   robert <ekesineugwu5@gmail.com>
Date:   Fri, 6 Mar 2020 02:18:53 -0800
Message-ID: <CALM=UYrAk5o-ZtrP-UNyKcD1kQSVDMfEt+7ir49gHSSdFKo-Lw@mail.gmail.com>
Subject: help
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQrQnNC10L3RjyDQt9C+0LLRg9GCINCR0LDRgNGA0L7Q
sdC10YDRgiDQkNC90LTQtdGA0YHQvtC9LiDQryDQsNC00LLQvtC60LDRgiDQuCDRh9Cw0YHRgtC9
0YvQuQ0K0LzQtdC90LXQtNC20LXRgCDQv9C+INGA0LDQsdC+0YLQtSDRgSDQutC70LjQtdC90YLQ
sNC80Lgg0L/QvtC60L7QudC90L7QvNGDINC60LvQuNC10L3RgtGDLiDQkiAyMDE1INCz0L7QtNGD
INC80L7QuQ0K0LrQu9C40LXQvdGCINC/0L4g0LjQvNC10L3QuA0K0JzQuNGB0YLQtdGAINCa0LDR
gNC70L7RgSwg0YHQutC+0L3Rh9Cw0LvRgdGPLCDQv9GA0LjRh9C40L3QsCwg0L/QviDQutC+0YLQ
vtGA0L7QuSDRjyDRgdCy0Y/Qt9Cw0LvRgdGPINGBINCy0LDQvNC4LCDQv9C+0YLQvtC80YMg0YfR
gtC+INCy0YsNCtC90L7RgdC40YLQtSDRgtGDINC20LUg0YTQsNC80LjQu9C40Y4g0YEg0YPQvNC1
0YDRiNC40LwsINC4INGPINC80L7Qs9GDINC/0YDQtdC00YHRgtCw0LLQuNGC0Ywg0LLQsNGBINC6
0LDQug0K0LHQtdC90LXRhNC40YbQuNCw0YDQsCDQuCDQsdC70LjQttCw0LnRiNC40YUg0YDQvtC0
0YHRgtCy0LXQvdC90LjQutC+0LIg0LIg0LzQvtC4INGB0YDQtdC00YHRgtCy0LAg0L/QvtC60L7Q
udC90L7Qs9C+DQrQutC70LjQtdC90YLQsCwg0YLQviDQstGLINCx0YPQtNC10YLQtQ0K0YHRgtC+
0Y/RgtGMINC60LDQuiDQtdCz0L4g0LHQu9C40LbQsNC50YjQuNC1INGA0L7QtNGB0YLQstC10L3Q
vdC40LrQuCDQuCDRgtGA0LXQsdC+0LLQsNGC0Ywg0YHRgNC10LTRgdGC0LLQsC4g0L7RgdGC0LDQ
stC40LIg0LTQtdC90YzQs9C4DQrQvdCw0YHQu9C10LTRgdGC0LLQviDRgdC10LzQuCDQvNC40LvQ
u9C40L7QvdC+0LIg0L/Rj9GC0LjRgdC+0YIg0YLRi9GB0Y/RhyDQtNC+0LvQu9Cw0YDQvtCyINCh
0KjQkA0K0JTQvtC70LvQsNGA0YsgKDcsNTAwLDAwMCwwMCDQtNC+0LvQu9Cw0YDQvtCyINCh0KjQ
kCkuINCc0L7QuSDQv9C+0LrQvtC50L3Ri9C5INC60LvQuNC10L3RgiDQuCDQt9Cw0LrQsNC00YvR
h9C90YvQuQ0K0LTRgNGD0LMg0LLRi9GA0L7RgdC70Lgg0LINCiLQlNC+0Lwg0LHQtdC30LTQtdGC
0L3Ri9GFINC00LXRgtC10LkiLiDQoyDQvdC10LPQviDQvdC1INCx0YvQu9C+INC90Lgg0YHQtdC8
0YzQuCwg0L3QuCDQsdC10L3QtdGE0LjRhtC40LDRgNCwLCDQvdC4INGB0LvQtdC00YPRjtGJ0LXQ
s9C+DQrQoNC+0LTRgdGC0LLQtdC90L3Ri9C1INCyINC90LDRgdC70LXQtNGB0YLQstC+INGB0YDQ
tdC00YHRgtCy0LAsINC+0YHRgtCw0LLQu9C10L3QvdGL0LUg0LIg0LHQsNC90LrQtS4NCtCS0Ysg
0LTQvtC70LbQvdGLINGB0LLRj9C30LDRgtGM0YHRjyDRgdC+INC80L3QvtC5INGH0LXRgNC10Lcg
0LzQvtC5INGH0LDRgdGC0L3Ri9C5INCw0LTRgNC10YEg0Y3Qu9C10LrRgtGA0L7QvdC90L7QuSDQ
v9C+0YfRgtGLOg0Kcm9iZXJ0YW5kZXJzb25oYXBweTFAZ21haWwuY29tDQrQoSDRg9Cy0LDQttC1
0L3QuNC10LwsDQrQkdCw0YAuINCg0L7QsdC10YDRgiDQkNC90LTQtdGA0YHQvtC9DQo=
