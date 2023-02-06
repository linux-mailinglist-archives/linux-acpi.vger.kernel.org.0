Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CD268C4B3
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 18:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjBFR2Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 12:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBFR2R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 12:28:17 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFF3A89;
        Mon,  6 Feb 2023 09:27:49 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 41B57260FD4;
        Mon,  6 Feb 2023 17:27:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BFD3E260F34;
        Mon,  6 Feb 2023 17:27:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675704460; a=rsa-sha256;
        cv=none;
        b=pCnfwdmCKaEgpRrn7FRXV1v8vAMl1d43a4C1RAN8/G1QikRcAt3mjX9jY+sH/SVwuUlSvE
        fAk4YnRwo1jVOq5lTqlBsOCwHcNLSMja0eenGke6XwADUzsmM5knLnQp8QLaTmhKiALtMu
        tQ3WEU/vv837XvhNvcUvZA12NG596Ts5KgbyTb+1/Z2s4DZEqf0Wlx56HSyzr7iPbLIxrU
        rS8625uu1L4ViqTLLsbzFqZ6klSn9fLWep/Ov7cCHt3OR1M/VumCaapR8xb4cy+D47AZGG
        mV0jSU1AJJYR79aaYw+wER1fIsVvn7njtkIU6q3a7Bbll6NX9+E0jwbsED8aYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675704460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=guMc6hsiXGpalu0jr5Z0AEUYKVM2wKO59VlN/G9yblk=;
        b=qIYusFZ4+eqRr4VbUQ5yr+Z/dI3jX1G0M5eFzivoj6cpGOb3BkaUR/AM7/3JPYTzE7nO3c
        vGmDmQSIS+wDweev1zWqxuMg2IwboYeF4TDbNJpJHsjcm0x7TssIt5xggC/OqDvf8MDf7G
        RBZsZt9cPYW+Q12tBBtFMvuKkQQ8IZ8X2Olw9rgP5ebCp4Tj9dv808sf1lMY7H1bZG4bSC
        e1PE79gXNGM8Jny1biYsIv0tGdccdaLvD2LvdkAk0ryeYyxH9lV9pD1dIKp8RYT2libZlo
        ed6zoOFU63EGTBFO57UT1ZK0N0Ny0zCL7wvlnh+BO9oS5gV5uIn42yv2tqheYA==
ARC-Authentication-Results: i=1;
        rspamd-544f66f495-sp79h;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shade-Fearful: 0a702cd819bcb5c1_1675704461055_4197068008
X-MC-Loop-Signature: 1675704461055:1861061609
X-MC-Ingress-Time: 1675704461055
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.110 (trex/6.7.1);
        Mon, 06 Feb 2023 17:27:41 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4P9Y9m0d9fz9t;
        Mon,  6 Feb 2023 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675704460;
        bh=guMc6hsiXGpalu0jr5Z0AEUYKVM2wKO59VlN/G9yblk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Nu4mZLu6eXXsFuG1qopNmg9ygmjFl98KLdVMLpjIwokO3awmYsZ+j/5RttTz8r1fU
         MagIjB/6LJYKufamb/pzF/5+EYBdoHk/cHRUhh9pzXQgbMGEAKCMVbWr2Z42970Rpx
         CftCLUJxu1/t/7bVVgYFGIk71p1Z1M/SMIEhiqstuXLP6Tsr/yo6tk7eOqUTP2KX2s
         Dct4So7RYRmLbSCGO2no/G0ygG5hUPQwyNqBGM27O2+BU45Awxqn6L5F2AWRX+MJo8
         3vFceRoCX0KpEfYXuidSqzEfQZ+pcB2oh52rF5J4uISLHmqx/a4J4mhkG7GyOpMNbI
         N3GI5BxijFbBw==
Date:   Mon, 6 Feb 2023 09:27:37 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/18] cxl/Documentation: Update references to attributes
 added in v6.0
Message-ID: <20230206172737.chyul7vz3cpxij4b@offworld>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <167564535494.847146.12120939572640882946.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 05 Feb 2023, Dan Williams wrote:

>Prior to Linus deciding that the kernel that following v5.19 would be
>v6.0, the CXL ABI documentation already referenced v5.20. In preparation
>for updating these entries update the kernel version to v6.0.
>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This one seems better for v6.2.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
