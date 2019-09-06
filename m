Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53FBAB932
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfIFNZb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 09:25:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35774 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfIFNZb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Sep 2019 09:25:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id 100so5728074otn.2;
        Fri, 06 Sep 2019 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:references:in-reply-to:subject:date
         :mime-version:content-transfer-encoding:importance;
        bh=3plW1l6912WWdE/yvCMMT+DGRz02GchL5U8Ixz8OSJc=;
        b=dH3mZeInNYg6vWgBgKZ7bMBS6VXeji19fIpgylTv+jzM/XGHkAAXpj6xnfDCpxReak
         nBszE/KpU/0YW6hiRfCXG4f7EIv4NCnnO0beCbFIdFhWKwjjd+v+mdHobi8af41qeNyU
         joH6B++dAiDN3UjyYT8fIw4BVVN5XavmeEm/4HjupykmSWNRMrGUhlzXqa9ccd0X40uA
         IhidZTRW+nAsiL30Fc2U3tbL+vy4a9kVNYIxHYrzYCiD/smgOGizBFfc78Cd3ok6KI4N
         FqNvpaG/H3peNb1gRwfUl8LsaPj3wFbEsU44Ptfl9+ug7iJgrzcr50iEUR3LKluv2jOk
         0C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=3plW1l6912WWdE/yvCMMT+DGRz02GchL5U8Ixz8OSJc=;
        b=oG+rds/HQIgTjRK6s5ZXTD306W6lJPWwChHTTVUIPR/8uBAwkCtbYLyh/pCpHKa1rc
         59mVaUf42/qG2r/eZeLf/ddjc+JikR3P53gY0zyXIpdFDXry25VRJkMycixo05qyprCK
         KNOq4g4/t1ydcCScPqz9f4O9ck+4DbAiqn10mriflaKfuJvug+pkxVALjIx2f8DOFk1Z
         u2lDb7H+4IBe79KB56KYRMpGNU94KXptuDD/Z1BKAWsQyyHu92nefChtK0P0rfvzn2DY
         Jdz5mbVJnquid+gVH7IedDLHnqEcTLtryIhE4m4FjzwrNX/HndvSSp23x0liaA1FL3cL
         hfgA==
X-Gm-Message-State: APjAAAXSiiL+FQuU5KHU+xTJ9Q4vW3vCMC2EwOcOqJfLKheKUy23sByh
        lipZ31nWDZ65aAk8KGLhRBI=
X-Google-Smtp-Source: APXvYqyYVybcVpGualf4IbZ+OjnNF65FSuShTUyaI2lCW+yA7IyWU4DSBGMbSZyW51YCs4y2lSr+nw==
X-Received: by 2002:a9d:618c:: with SMTP id g12mr6881158otk.136.1567776330863;
        Fri, 06 Sep 2019 06:25:30 -0700 (PDT)
Received: from chip ([2605:6000:f350:3e00:1997:696d:15b8:ee93])
        by smtp.gmail.com with ESMTPSA id s9sm1875028oth.70.2019.09.06.06.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 06:25:30 -0700 (PDT)
Message-ID: <5A2ADDC81DB5421290EB97D1178C0BBE@chip>
From:   <chip.programmer@gmail.com>
To:     "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        <Charles.Hyde@dellteam.com>
Cc:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <nic_swsd@realtek.com>,
        <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <1567717304186.90134@Dellteam.com> <1567736007.7317.71.camel@mhfsdcap03>
In-Reply-To: <1567736007.7317.71.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] net: cdc_ncm: Add ACPI MAC address pass through functionality
Date:   Fri, 6 Sep 2019 08:25:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3528.331
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3528.331
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>> + if (strstr(dev->udev->product, "D6000")) {
>> + sa.sa_family = dev->net->type;
>> + if (get_acpi_mac_passthru(sa.sa_data)) {
>> + if (!memcmp(dev->net->dev_addr, sa.sa_data,
>> +     ETH_ALEN)) {
>> + if (!cdc_ncm_set_ethernet_address(dev, &sa))

> How about use one if-statement instead of these three if-statement?

While using a single compound if statement is possible, my experience is 
that using multiple if statements will make the code easier to debug and 
maintain by others who come after me.  What is possible to do with code is 
not necessarily what should be done.

