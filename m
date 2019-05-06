Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161981537E
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2019 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfEFSOS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 14:14:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44427 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfEFSOS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2019 14:14:18 -0400
Received: by mail-io1-f67.google.com with SMTP id v9so8063438ion.11
        for <linux-acpi@vger.kernel.org>; Mon, 06 May 2019 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=bi1X8E2iJDbOTLkAMJo/IBi1WYDSDyokTPbiJ53Ivxs=;
        b=TJRCGKtEXJDmSGGyA07GXyq5cu9+tq3LBaNSRxUT0BZZDVFM4LmrCmly/KfJo84I5Z
         3auKvn5kVMlG32tq7aHcagk45FMqrBYza/Oa9XxyvV7ozMKX8cASX53o8SHr2ccIUDmD
         pUk3zaZhy4m5wrR6xFY3/mEHVvkOvddzct5hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=bi1X8E2iJDbOTLkAMJo/IBi1WYDSDyokTPbiJ53Ivxs=;
        b=Z5tsZesMrcQggsWnKsrn+ZmkaHa3ia+qRqBgyOkzGVUTBUWs5J0U5v+eolnLpvROYS
         WO6D3TA5vnA706i2lQBJWIEQC9H4WGTwTfe91+vr+8Y3S15X48aSGEfXWQtBS3a+yafR
         rHC4Zlp+X0SpJvGt1SFeKwff5l8spl5uXz/e85BDkvMa4ECRktDleodMFTmuo96yycxt
         Nwbd+dcUYxE2/aAPi06ufktiR8C76pKfNRL0TItRca1jqp/3a/eOp1QqtKEu2kSoprj0
         Ah3HxdxjcbvQMUKVoyXA1XaMSv/hMZEZkt/yQAUrRlwH88QJIGDpHiG6xq9iOMeUOpvh
         WEiA==
X-Gm-Message-State: APjAAAU+UubtT8iMZh+sryrOuUCzWDQ5z7t3mW0rr0QhxjYWAjOY+Ahx
        aAM3ZEIAaJF9nE3r8g46X332kQ==
X-Google-Smtp-Source: APXvYqxmH1MfnNyv9pTsAAZjt8KEU+PLQD878IbPuF3Kcy0xI+f0xrPj83IaLJSfaeDvvPIweCR+EQ==
X-Received: by 2002:a6b:8ec4:: with SMTP id q187mr11218439iod.280.1557166457616;
        Mon, 06 May 2019 11:14:17 -0700 (PDT)
Received: from localhost (50-46-216-15.evrt.wa.frontiernet.net. [50.46.216.15])
        by smtp.gmail.com with ESMTPSA id d133sm5546120ita.5.2019.05.06.11.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 11:14:16 -0700 (PDT)
References: <20190505220524.37266-3-ruslan@babayev.com> <20190506045951.GB2895@lahna.fi.intel.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ruslan Babayev <ruslan@babayev.com>, linux@armlinux.org.uk,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        wsa@the-dreams.de, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
Subject: Re: [PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on ACPI based systems
In-reply-to: <20190506045951.GB2895@lahna.fi.intel.com>
Date:   Mon, 06 May 2019 11:14:15 -0700
Message-ID: <871s1bv4aw.fsf@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Mika Westerberg writes:

> On Sun, May 05, 2019 at 03:05:23PM -0700, Ruslan Babayev wrote:
>> Lookup I2C adapter using the "i2c-bus" device property on ACPI based
>> systems similar to how it's done with DT.
>> 
>> An example DSD describing an SFP on an ACPI based system:
>> 
>> Device (SFP0)
>> {
>>     Name (_HID, "PRP0001")
>>     Name (_DSD, Package ()
>>     {
>>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>         Package () {
>>             Package () { "compatible", "sff,sfp" },
>>             Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
>
> Hmm, ACPI has I2cSerialBusV2() resource for this purpose. Why you are not
> using that?

I am not an ACPI expert, but my understanding is I2cSerialBusV2() is
used for slave connections. I am trying to reference an I2C controller
here.
