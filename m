Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C08676A36E
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jul 2023 23:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjGaVzQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jul 2023 17:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjGaVzP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jul 2023 17:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38D139
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690840468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Id3I1cJMIHoKEHxCvdzG3jxQMHabAL/BIyDQ5h52PeY=;
        b=D3qcu2oovxXfhBy2mPSWYYdjdveO47MqX4dOgK6uS6cHgrrQjjLHJlJB4SEfzBz3yuZzpT
        i+KUUH0C1nkxOhNt//bzRdilE9bW0TdN9JcI2fpB1+uZXyi+34Q/aHsdDAd1nl/AjRI+h5
        wMcsnXvIZ1gsL6vYhQ7kYl7kkURPRaA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-9ijJ0FUVP-GOtDAcvr1wiA-1; Mon, 31 Jul 2023 17:54:26 -0400
X-MC-Unique: 9ijJ0FUVP-GOtDAcvr1wiA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3176eb6babbso2845805f8f.1
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 14:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840465; x=1691445265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id3I1cJMIHoKEHxCvdzG3jxQMHabAL/BIyDQ5h52PeY=;
        b=ex8uXw8j7maD1+qb6Wu49adiplRcw4GXopYpDdLDRE7jAYSR7vJWn7kBvIdWhTkKoQ
         o7ZJufc3GgcSho8emzxKfypGea3/jc1DYEWQ9YV3PcmbkMdSSsJYttpWY1eukfW4IHhF
         oqt3Xz6EO24PI1PAWA12mHCAJPy+BuqLoM+qvJ9/taEVaAQaiW25Zjlz9SKvwc1zNIbt
         3exFmZSO8svGnvx85+UzLddGksKgFkta34Aso8tTmjxPeM37LOrVL1L+uKsvkUkkYjio
         FB7bqRP/2n3BiWkQxM//Sw5LYwZoKUaPmzVFSZKOzG5Vj8X1QKikYrl2mva/ozIDBH9/
         +qcQ==
X-Gm-Message-State: ABy/qLbIqJsRtBR8FTIhrrn9q74fcK0ZMcbqku/MHgQcs66Bg79LuVd5
        QJvBTsjxUlOHOUswF7+jCk1j4UMr11QZYDRGzyiJr9jyUU8ZfUYj73rrWPho49ypI+0ah8H1dQ5
        7cOIZFYOwwt9vMgTDwiyACw==
X-Received: by 2002:a5d:6692:0:b0:314:3e96:bd7e with SMTP id l18-20020a5d6692000000b003143e96bd7emr742575wru.4.1690840465586;
        Mon, 31 Jul 2023 14:54:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEX9SucAtVs7in4FOojZQ/GuK6o+u4Hoj5NLmRuHHukOPExj5qXSjAjeXOkO4itn74lrQf+Jw==
X-Received: by 2002:a5d:6692:0:b0:314:3e96:bd7e with SMTP id l18-20020a5d6692000000b003143e96bd7emr742567wru.4.1690840465319;
        Mon, 31 Jul 2023 14:54:25 -0700 (PDT)
Received: from redhat.com ([2.52.21.81])
        by smtp.gmail.com with ESMTPSA id p3-20020a1c7403000000b003fbc9d178a8sm15014373wmc.4.2023.07.31.14.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:54:24 -0700 (PDT)
Date:   Mon, 31 Jul 2023 17:54:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230731175316-mutt-send-email-mst@kernel.org>
References: <20230731144418.1d9c2baf@imammedo.users.ipa.redhat.com>
 <20230731214251.GA25106@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731214251.GA25106@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 31, 2023 at 04:42:51PM -0500, Bjorn Helgaas wrote:
> I would expect hot-add to be handled via a Bus Check to the *parent*
> of a new device, so the device tree would only need to describe
> hardware that's present at boot.  That would mean pci_root.c would
> have some .notify() handler, but I don't see anything there.

That has a big performance cost though - OSPM has no way to figure out
on which slot the new device is, so has to rescan the whole bus.

