Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160DD71742
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2019 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfGWLif (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jul 2019 07:38:35 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:45693 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfGWLif (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jul 2019 07:38:35 -0400
Received: by mail-wr1-f49.google.com with SMTP id f9so42771997wre.12
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jul 2019 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bo6Pg3X5Aw/dLqsvKdZ7JqMOS8iWBZzwB07NtyVy4Q0=;
        b=O7xAVrLHIyYEthzgmcjgK5j5j31fac9bjPiyzx5RZUXCJDQFGQtIQJFYKX4vt6dx5G
         /E8Jzm+vueyQ04KYueUmKchpG0Dodm3kWL1dBTVnRlg2q/FrByNFToeYT4jJE+YkfXK1
         2yRAxm4nYWquZZ68xtxvK96r85x6Rb4HS1pmvi71EhcwpEimmb9/sS0/3VDbVG5HdXNk
         QqxKH+MmN28vUqtthKaFhD7PMutpB0d1JeX/jWIFh727QMWyyD02JbESyCid7usEkjTF
         dswdsyH3WIloYzfhXhdzlYGsWMBH62Psxn61G2Yxi2pNDlva2y3NG5BW7tmQmh9HlCyx
         a6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bo6Pg3X5Aw/dLqsvKdZ7JqMOS8iWBZzwB07NtyVy4Q0=;
        b=NPECT+VcR172+QKXP2SSrqxHgkj36Khq0SaigqYkiWcZwZBJkJptVP1IFK4chlykPC
         InqNfmslcnBuGO36yDgnoENDsnYgRX35BPRZldFWDrXy1l1amuJldykc6O0gkXcbvS8V
         MO9qm1cGWJ9qDXE2D2wX+tzywXjvNgSvznyyj02Z63+4OpUEppL6oKTgSpfqTNuRUiN4
         xfygKX5+AfrWgS8a8Rf32z8Fw5PgQMfOGyTB4UndBAs4N4SUQM0TDShkyZAgnqt53h3P
         b6qkJoFr3hVkCa7IiApPn1NgI7My4Fzkb/wk8NMWxpdtwlLoaGG/OstGbHff2s1AqLAm
         w7ug==
X-Gm-Message-State: APjAAAXXlVUfTkD+sejkTQ+oxrmKif9b+WhL1mNmLDobXzy9f+VuuoSw
        3I0DZH8lhslzsskyIHUOT2Y=
X-Google-Smtp-Source: APXvYqzwYDp+yqQlfr5Z3TWx7sgLs/25YWtBRjREkB1J5c42O2hZctA7LYsYKDHGfrMmdIf7U1cRrg==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr82429489wru.141.1563881913309;
        Tue, 23 Jul 2019 04:38:33 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5A8B2.dip0.t-ipconnect.de. [217.229.168.178])
        by smtp.gmail.com with ESMTPSA id o7sm14922315wru.58.2019.07.23.04.38.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 04:38:32 -0700 (PDT)
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
 <88077d9c-b2b7-5fc6-37e9-fa12d6aebe73@gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <5a6f7a66-035c-eab0-6cdf-e10411e30cef@gmail.com>
Date:   Tue, 23 Jul 2019 13:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C614AA8@ORSMSX122.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/23/19 1:01 AM, Schmauss, Erik wrote:
> Sorry about the late response. This slipped through the cracks.
> I've sent them an email just now and I'll keep you informed

No worries. Thank you.

Maximilian
