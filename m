Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F429290B2B
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbgJPSMN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391007AbgJPSMN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 14:12:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2857C061755
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2020 11:12:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e22so4489740ejr.4
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2020 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KL1IjUStMhQCFtfovQWJh8Jb/Mss3XgTN9JXM1OzgKQ=;
        b=nCmzpADjn6lWmk/cJIZL/0H+TtyQVQoy2Rje4CDydYYZD/fMBMK4+mRCe/cUkiHVZD
         YM9hpV93oj3Y7JZMS8m2idkj+ObHWcGN4TsuTPhm4D/gIUTi0v2/tidwquT62K46s507
         RoEDb/vwJGc43Xm2ztoi1zZhan6FE03ILTxxpz0c7lOMh6owcPbC7SqZB9NnHSi1Kjv9
         SR+V4vhLULsxAD6kQNbaViaFyGwM32oRHzWT9xZwJ/S+XI71obJ5bHfns2VtVY09qVl2
         /TcpRHBfXeTNDcEZQ6eB+BL344Cxo6PPJgPlDwA4cT1vumn2ityKGEZSJ8xC6ELeTxwV
         n2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KL1IjUStMhQCFtfovQWJh8Jb/Mss3XgTN9JXM1OzgKQ=;
        b=gIJt4ZyoJCw/vAYKAxKLe8hDiUZS6NxbiTRyknJYLAZmK79c3y9FKzTrH3euI91RLx
         f27EtMEBNuB2Z4DLq4rwlLTEM6ZfjRqkqhGfb8dYQquexpRumDcKTDf+RmsoTKQE1h7O
         gYiBuqWS1pogZWIbfzZh90jghzRz3ob01ywXGOGYtNxmfKVKbD/UOkwl/G9dkqx4Ukwx
         JhYHZOFGGSWakYBYRFG2RF3TjdZ2APvA2L8fWHlNzzpzWQV6rdemoteeSQro9oLWvUPZ
         tR2EIhLKpCzNPXzw2rW0PGcImZMIj2/O6C+xEjo6STXxyUeqsNLsRNxfuIC2mXhZaSUt
         P2cw==
X-Gm-Message-State: AOAM5303+2FfjZCNrmGI0zHWMWWfxuGStFG6UcAnkO5qYoPr1N8UAyxp
        OVNy+pRM6Hm7HsNxKKtLgKbFBQ==
X-Google-Smtp-Source: ABdhPJwoa2VxwM0Q1aACfU+VpUsaIM6Lo7z3y2iVhbiqD0vx5pcczCOIa9y/bQ5zT313ldX6mxDI+A==
X-Received: by 2002:a17:906:f118:: with SMTP id gv24mr5076405ejb.174.1602871931411;
        Fri, 16 Oct 2020 11:12:11 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:6f98:5069:d66d:d5c0])
        by smtp.gmail.com with ESMTPSA id q19sm2266942edc.14.2020.10.16.11.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 11:12:10 -0700 (PDT)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
References: <1748021.N9i9sLPJ40@kreacher> <9373262.piL2bvXoCD@kreacher>
 <3b69e0d0-fb8a-92b4-42fd-f2a8fcdd642b@tessares.net>
 <1735226.fPvPZg4QOa@kreacher>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH 4/6] ACPICA: Add support for using logical addresses of
 GPE blocks
Message-ID: <fe077e28-2421-6d48-d55a-882b802e47c1@tessares.net>
Date:   Fri, 16 Oct 2020 20:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <1735226.fPvPZg4QOa@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 16/10/2020 19:15, Rafael J. Wysocki wrote:
> On Friday, October 16, 2020 4:30:55 PM CEST Matthieu Baerts wrote:
>>
>> By chance, do you already have a fix for that?
> 
> Can you please try the appended patch?

Thank you for the patch, this fixes the compilation warning I got.

Reported-and-tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
