Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1415D3B172F
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 11:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFWJuA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 05:50:00 -0400
Received: from mail1.perex.cz ([77.48.224.245]:57042 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWJuA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Jun 2021 05:50:00 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 68AACA0046;
        Wed, 23 Jun 2021 11:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 68AACA0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1624441661; bh=iQKSfYdGguOxhcWoXnpPevbxvqE7Ys35BcjvPAc9G4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W5p0xh2tNJAFnPa9zM4f+maPx6YRMFi83HLu4P2s4mWEzZ1rb5yWjgkFodpOYuk5+
         Wvj0mChkMtf9Z5pyjvT3Li3NkBW18LyqAQZtPJ0hGkX5/EAK8z0BAjH5iUCGabRv6Y
         fBdliTUa5vbHJ9ValgzuU8+tRQtQ0cJTr3pg5lMU=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 23 Jun 2021 11:47:37 +0200 (CEST)
Subject: Re: [PATCH] PNP: moved EXPORT_SYMBOL so that it immediately followed
 its function/variable
To:     Jinchao Wang <wjc@cdjrlc.com>, rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210623094045.41335-1-wjc@cdjrlc.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <e52956bd-c7db-1494-44fa-921a976cea94@perex.cz>
Date:   Wed, 23 Jun 2021 11:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210623094045.41335-1-wjc@cdjrlc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 23. 06. 21 11:40, Jinchao Wang wrote:
> change made to resolve following checkpatch message:
>   WARNING: EXPORT_SYMBOL(foo); should immediately follow its
> function/variable
> 
> Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>

Thank you.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
