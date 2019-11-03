Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4170ED3E7
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Nov 2019 17:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfKCQ4G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 Nov 2019 11:56:06 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52855 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727682AbfKCQ4G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Nov 2019 11:56:06 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A0CE9205B8
        for <linux-acpi@vger.kernel.org>; Sun,  3 Nov 2019 11:56:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 03 Nov 2019 11:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=WS0nMMhD9JGQHjpyBjU9TZabQE
        LLKsFPlYo3tLYnWLs=; b=dXPJ/BL8z99i77U80Q6jfYSYbID+kVxBPxFhaS3U3M
        W0xMXaRI5qneYRGCcc2cf/AwuK1DJR4xU4ht7NE/OMUcb+ZM3BnOgr6nwR9F65E5
        V9LF552zTcBh+5d6yTg5tzFDw1SeaxrQQnYa+pvCzRuqz3pXwNojmr5WlD9FvF+l
        ES/CiF9UFCIU42IE8MVY+1w7WZcJbbXscM6dgqU/TIc+PRceXkm3X4Ek7ArRq4nt
        h3+NRtV502WFcj1yVLqdECdrzP+/XeaSUHrlZZXW3YHBYHBec1GDYhaoq+nflMSy
        LVmGGIwbeS9VLhyPMzM1OST8w2gWbmTOidEGG/JFBN8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WS0nMM
        hD9JGQHjpyBjU9TZabQELLKsFPlYo3tLYnWLs=; b=Wd+sZ79wdGInVOsjLLIyuD
        zMF3QHFKnzfh7FmsLXQQ7FMRS2M33HAfttcJfOwAAJFq4PO5fAMH/HFuPZRpCNZC
        0VKTrZQBzVV/krQ/PuDZpoz3UiN65clBGJJKXBOykKfblKWIlAeRkGwiJ7q5M7qH
        RVv0xkzRJMRCS1EWWPaGm/RreMIXTZzMokaY8295ruEtk8XGDiTTVGZOe3CJcYLt
        kMiBoR+dCaldF9cTJGP6+dgkCqbKCWF11dDfsN6wgSctz3KK+Hk0PIPiwR4Qznz/
        qetcbrxFd97AwQz1DqOGniDpTYPAeC7Z2HJLJtyG+kvkQMWWpwlNfU1QrJ6CIOJg
        ==
X-ME-Sender: <xms:pQa_XVQ1ggk13iIhco_dQqq1Eu8hvYQolfw0ySOTnLqX8VxfokvDVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudduuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertd
    dtfeejnecuhfhrohhmpefklhhgrgiipgnptggrlhcuoefklhhgrgiisehfrghsthhmrghi
    lhdrfhhmqeenucffohhmrghinheplhgruhhntghhphgrugdrnhgvthdpkhgvrhhnvghlrd
    horhhgnecukfhppeduheelrddugeeirdefvddrheeknecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpefklhhgrgiisehfrghsthhmrghilhdrfhhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:pQa_XURMaVQxcIi03cgZ3Bwv6F-xm7WoMGIuIF4K2K-VHJ7NDCugiQ>
    <xmx:pQa_XTIoJTQwB8Zjtzzak_tTG3YqRsBrcs4HOOPpJnNAylJSX93KBQ>
    <xmx:pQa_XbHIvZsF2cfmXkJk6cfOPuXR9KbgLMg5sh0f_AouOgCcJbZD5g>
    <xmx:pQa_XdduLqffFUTphsvQRguhDUtHWfzEOD0ThB4g7UzLe-eIoEkGNg>
Received: from [192.168.1.36] (unknown [159.146.32.58])
        by mail.messagingengine.com (Postfix) with ESMTPA id EBD4280059
        for <linux-acpi@vger.kernel.org>; Sun,  3 Nov 2019 11:56:04 -0500 (EST)
To:     linux-acpi@vger.kernel.org
From:   =?UTF-8?Q?Ilgaz_=c3=96cal?= <Ilgaz@fastmail.fm>
Subject: Kernel requiring acpi_osi= to boot
Message-ID: <8ac3844a-2c53-dafa-47df-16b1a0b8d020@fastmail.fm>
Date:   Sun, 3 Nov 2019 19:55:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[1.] One line summary of the problem:
[HP Pavilion 360 - 13-a200nt (ENERGY STAR)] Kernel parameter acpi_osi= 
required to boot

[2.] Full description of the problem/report:
When booting my HP Pavilion 360 - 13-a200nt (ENERGY STAR), it stops with 
just blank (black) screen and the Caps Lock doesn't respond when pressed 
stating machine doesn't respond to any input at all. If you add 
"acpi_osi=" to kernel parameters, it boots fine with entire ACPI 
functionality seems to be working.
More details with relevant hardware information is at:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1848445

[3.] Keywords (i.e., modules, networking, kernel): Please do not put 
anything here. This is how Kernel.org uses an undocumented keyword 
system, which has nothing to do with Ubuntu Tags system.

[4.] Kernel version (from /proc/version):
While booted into the newest upstream mainline kernel only, please 
execute the following in a terminal and paste the results:
cat /proc/version
Linux version 5.4.0-050400rc5-generic (kernel@tangerine) (gcc version 
9.2.1 20191008 (Ubuntu 9.2.1-9ubuntu2)) #201910271430 SMP Sun Oct 27 
18:33:09 UTC 2019

[5.] Output of Oops.. message (if applicable) with symbolic information 
resolved (see Documentation/oops-tracing.txt)
none, no output shown

[6.] A small shell script or example program which triggers the problem 
(if possible)

