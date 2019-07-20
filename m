Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C047D6F0B2
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Jul 2019 22:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfGTUpL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 20 Jul 2019 16:45:11 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55259 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfGTUpL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jul 2019 16:45:11 -0400
Received: by mail-wm1-f46.google.com with SMTP id p74so31639598wme.4
        for <linux-acpi@vger.kernel.org>; Sat, 20 Jul 2019 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sn31xa1Rk0JJs6T66RPNXZxvBRj8Q+uES2N2f4iqY88=;
        b=O5qcZFEGhBZZE/9M2NwPcAo+J2lCc+EGDacEKd/nFCfGYRFooKe5Yh7m35zmniAN/0
         nOelkINJEQbH5i+G6zRStLLFC47IDFAp5GkayF5bmqBgCw/K8Rwg/ZGTsPQP2zMV1R1g
         Wo8HWW90gnCADlBTSMoI4ONjLV1obC1ARpEwniGT1jkrpRlHFV3Q8N/TMQyofWrRAkNj
         a10I9VdRx+am3tTe7iWrPwEuGQ82c49tcJnobNo38noWeEVEUuueyNPbjwRqlUuJ0mHC
         piapLoU73OKmzWMJPFropcnp8SxSsXNj17D/q4HoibhRSwMZ3znS5mPlATZNv6/tF3yS
         0lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sn31xa1Rk0JJs6T66RPNXZxvBRj8Q+uES2N2f4iqY88=;
        b=KO8jTORlIaHNvJROI46HixwWhSKoa6fVKi5hkEt6ZnYiTilxihfTB3LKgluutM5m7T
         tEl8ARrYcsiQfoPxJmpU8R/YvE7qC9wwf8dlqoCKrL8YZqj9OD+x7scS8hkAzArmCFzy
         ZiPuYYZIrzw/UIqWi5rTGxuOIZh27ygUFXFCxJ6GYRdhCnqVI6eNZpP82rUj6qloWZNq
         JTkvBK3dfAxmBX0Qvzb7IC2gnhWJL1NjRec5pDApb1mK+GdpZjMX7L82+xEGNyKnajht
         jpNTJkbshps8xOxEL1kannz+F1tGEgMMtSeWpne0v00aIa5FL4rXYxay02sasxLWSvHC
         5s0A==
X-Gm-Message-State: APjAAAVlPG0oYUI5Kp2AHfgVjy74/Ae1KUYZUR0yHPfsC+ahZWFWWtUc
        HjPKckvNnXNFhCXw8+/ySTg=
X-Google-Smtp-Source: APXvYqyK5Uc0PW3qtUG3gXQqIgH1OllkXyOUEF4+jDiBgVXLhl0WP5Y2zhCpCUReCC/kYJEC5qrfEQ==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr56765953wmg.164.1563655509236;
        Sat, 20 Jul 2019 13:45:09 -0700 (PDT)
Received: from [192.168.2.202] (pD9EA3BA8.dip0.t-ipconnect.de. [217.234.59.168])
        by smtp.gmail.com with ESMTPSA id a81sm33058542wmh.3.2019.07.20.13.45.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 13:45:08 -0700 (PDT)
Subject: Re: PROBLEM: Calling ObjectType on buffer field reports type integer
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
References: <3ef42aa1-196d-f3db-0e5d-2fd84c198242@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C592D47@ORSMSX122.amr.corp.intel.com>
 <CF6A88132359CE47947DB4C6E1709ED53C59405C@ORSMSX122.amr.corp.intel.com>
 <fe4bcc1c-5c15-caa6-ce01-a5df962ff008@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C5942CA@ORSMSX122.amr.corp.intel.com>
 <51e156ec-c2ed-84be-13c0-99a213e1d4b7@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
Date:   Sat, 20 Jul 2019 22:45:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C595C50@ORSMSX122.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/22/19 10:28 PM, Schmauss, Erik wrote:
> I've been discussing this with Bob. I've decided to file a bug against Microsoft
> internally. I would like to wait and see what they say... I've never done such
> things so I don't know how long the process takes to get a response form them.
> 
> I'll post updates when I get them but feel free to ping us again in a few
> weeks if you don't hear back. We're still investigating their operation region
> behavior as well...
> 	
> Erik

Hi,

I assume there hasn't been any response from Microsoft?

Maximilian
