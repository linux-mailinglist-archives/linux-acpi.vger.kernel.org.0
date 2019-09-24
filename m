Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670CCBCC62
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfIXQZU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 12:25:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33989 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfIXQZU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Sep 2019 12:25:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so2686338wrx.1;
        Tue, 24 Sep 2019 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/8z2xiT5y7c0sYHUBqDpP1sTPc2++fhaDehe0ZWHJ1s=;
        b=ZcDHrlyH8zQTuO3Oty0sdGzuHnY99SzA+aZrZ4WdSJz4lQrGwsR7zE7qluKSUrN82W
         lldRilzThppfp93JScPF6p0JbtZaon2NJGpw3Rnn4BYvOFQYut3FE1OSq11lwJfCesW5
         CR23dZE8XKLkGYH3QGEn7JDqitIWdZT1asmmu/86OUHUPGyRlDktS2xSXYI8Howsx1Ss
         +xorRTZQFW0rdk5f2WSvG2Fq12+oQkur77V7aH3EUtnZADICGgOv2Gs+ZGRXZiFBtVU2
         2pypAkMZf3m3dm3FqZh8Kwh3Z9hyw9A6ujS7+MkEl2ZkGPRTk3UziBuRUUYwguhIWq3Y
         iSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/8z2xiT5y7c0sYHUBqDpP1sTPc2++fhaDehe0ZWHJ1s=;
        b=MrDpz93ktsVE8zIxB+ho7HDrbr2mSsr++gOGGtYerqEDGWbiugXdFvzCrnio5ru/cD
         My9Z00cO6VARq+RlGJIL2wHVj/8kmf3UtwgnJzbWXtEdFUjn2c14T0NE6o+8mZNKW3O6
         gcKFQSHoKgPsueJR2PEXBRr6ObahFLBWQ5jwhQT/cq8aFvM1IL4dGDFPMfLGsKLJYm5k
         bEO1bTW6i6NahUnECflfBgK5xxXxmpfxfBOyXDyZBjH5FJdM+Kb1sPvmMaRZY9Ng9bdS
         bIlVeTOWQsJfVrxqzWMWXByFmAo9luu1/+NSlMkNdS7MSSSJEv2rqfgT7iDaHnQM9ZSH
         XQAA==
X-Gm-Message-State: APjAAAVMmW4q+KPiB6AOzrkBseFndEz1ta/Hs/3/6ivlAiknpHQZR1gA
        vR8fbyqVxeyGr3qgN4sfZBG43J+u
X-Google-Smtp-Source: APXvYqz4IEx5a4rRxBsEIPXCAfpKngbgqRBvNjAPtf8DZ3B+2DyKS+jCxH9LU7jRugsinEQ99krbaw==
X-Received: by 2002:a5d:66ce:: with SMTP id k14mr3317416wrw.258.1569342317176;
        Tue, 24 Sep 2019 09:25:17 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5AB82.dip0.t-ipconnect.de. [217.229.171.130])
        by smtp.gmail.com with ESMTPSA id x6sm670907wmf.35.2019.09.24.09.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 09:25:16 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <038d0883-a083-e706-8df4-397ab79fc0dc@gmail.com>
Date:   Tue, 24 Sep 2019 18:25:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919195624.1140941-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi,

I have just submitted v2 of this patch.

Regards,

Maximilian
