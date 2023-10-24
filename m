Return-Path: <linux-acpi+bounces-871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC567D4E05
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADE21C20B3C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A681250FC
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b="E2HUeYhc";
	dkim=permerror (0-bit key) header.d=ibv-augsburg.net header.i=@ibv-augsburg.net header.b="rfzJINJN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CA7461;
	Tue, 24 Oct 2023 08:51:44 +0000 (UTC)
X-Greylist: delayed 169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 01:51:41 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45811110;
	Tue, 24 Oct 2023 01:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698137313; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dCcByXA50jlPc/5462sZaBYKE1yLuq8didSSqCaiBubc/EXXEqja6NYRBlfmv/CznH
    yY3b9Vr8Ha1wBKqnHAtCoSDJu+S6cjyBBSKyUfRatTBjbpJ4X0+E1G7uEW3pqljWqm4W
    u+Xb+evtzvEwK1GeQosGn45YP1mtRhOIvbNbQt3eKqLKr6SQLzGKOdPmKjM4Vpk7Mlv1
    WP0mC2COCNREel8omco3oWrfJJIXNtuOsmCf1Rhyg+dBfpkTHjkYP6sNmSeCoUh1ZHQF
    zYGJHKece8em7+Qs04hf4oKbYgkZdS3rgvHqIqxiRYZSBDJJwFEFsLGDMEgQ5+1mlDyf
    lYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698137313;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8DmN4MjoYkBhQY8ESnY7blQegmMPGHJ4AlxHqUCnUtU=;
    b=RAOA5Yq4NAHi1lIYy9fPITpAgKff26SsILB/yW7T6nHf5CnvVhAAGkKjC2IfqNaWP6
    u1Q5fr7hqcOpzATNQYVaFHuyKAOsNWI49DZ0UfLUJt12TGh8fJtcze4tS4uR1+usmjvR
    8c7gVEmsrOPEY5In93JSNg2RQO+WkKjhB3Ohk4mjap+rng/2FWSQJUxbXbHU5jN/EnL3
    j2TV3lKJy+bYwmRXbFoJCTs6rasJtKBY9QYfPVxrXmBeRl7/V1Q7UfQgcObeo6q3/OnJ
    eT6fCc7I4DqB6lIKyp6CkWwNRWOxJdiqRVhfTpfnHQjBC3sSW1qdOn8QWl6WIeADMq4J
    hZrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698137313;
    s=strato-dkim-0002; d=ibv-augsburg.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8DmN4MjoYkBhQY8ESnY7blQegmMPGHJ4AlxHqUCnUtU=;
    b=E2HUeYhcKPAGXcpVmL6LqqrMrF7Ib5R4o0KvG+smrDoI22sZJ+0L8/jX4/xlgN+f3N
    z+WyigESPlkHNmR1fQakN1a6hdwhgtDP80tJUWDoEqTu86iEDBGSvQxUdEy5D+iR/Ixb
    9E22vSQ5dIaYhiR1dTQAtIQ1NB7f5497UtmL4EH3DQp7UAmfr1h6UMLHpPqXqAr1rEuN
    85A8piSKfmxjzR77X5gDbMHuYu5b5Qp7sRToLmarTcvZQEB1Dcbx65fEWr8g4HPJ0dQ1
    X9GxoUSNJHDzdtFFZt4fiXj7SAX5+dS6dk/ue8mAN8yXWZ5af3VcMZ6PWC66i3bHobOv
    D2BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698137313;
    s=strato-dkim-0003; d=ibv-augsburg.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=8DmN4MjoYkBhQY8ESnY7blQegmMPGHJ4AlxHqUCnUtU=;
    b=rfzJINJNKVbLLy68yENYq1w7rR9Eo54SM0TqV2JqOUk6QkZFpiK29+LQbTdcWCt4go
    yEkVyJWl1w+392W9JGBg==
X-RZG-AUTH: ":KGMJfE6heLGk8b3w7Oa1fDtXwBjeDczIOHPRx8yNRKhFG/cxcP9dNdI9SxioDT8RvZMqtMfbyXFLOT+0odACkA=="
Received: from JADEVM-DRA
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id U33eaez9O8mWZhh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Oct 2023 10:48:32 +0200 (CEST)
Date: Tue, 24 Oct 2023 10:48:31 +0200
From: Dominic Rath <dominic.rath@ibv-augsburg.net>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>, bahle@ibv-augsburg.de,
	rath@ibv-augsburg.de
Subject: Re: [PATCH v3 3/5] irqchip/gic-v3-its: Split allocation from
 initialisation of its_node
Message-ID: <20231024084831.GA3788@JADEVM-DRA>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
 <20231006125929.48591-4-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006125929.48591-4-lpieralisi@kernel.org>
Content-Transfer-Encoding: 7bit

Hi,

On Fri, Oct 06, 2023 at 02:59:27PM +0200, Lorenzo Pieralisi wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> In order to pave the way for more fancy quirk handling without making
> more of a mess of this terrible driver, split the allocation of the
> ITS descriptor (its_node) from the actual probing.

it seems that this change breaks MSI-X (MSI?) reception on at least
the TI AM64x, probably most/all of TI's recent devices (K3).

These devices rely on a quirk CONFIG_SOCIONEXT_SYNQUACER_PREITS that
uses an address from the dts specified e.g. as

  socionext,synquacer-pre-its = <0x1000000 0x400000>;

to configure a MSI base address that differs from the ARM default.

With this change, the quirk still sets its->get_msi_base and clears
IRQ_DOMAIN_FLAG_ISOLATED_MSI from its->msi_domain_flags during
its_of_probe, but both get overwritten again during its_probe_one
with the defaults.

Previously the defaults would be set first and then the quirks were
applied.

I have no idea whether TI's use of this quirk was "correct", but it did
work, and since 6.6-rc6 MSI-X has been broken for us.

Best Regards,
Dominic

