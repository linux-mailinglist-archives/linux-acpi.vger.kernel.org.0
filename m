Return-Path: <linux-acpi+bounces-48-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC77AA519
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 00:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 31FB71F21A6C
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA938182CE
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 22:31:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80F9CA57
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 22:22:27 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06231FC6
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 15:22:25 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-195-nCruYfTANVavYpk8gD9WoQ-1; Thu, 21 Sep 2023 23:22:12 +0100
X-MC-Unique: nCruYfTANVavYpk8gD9WoQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Sep
 2023 23:22:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Sep 2023 23:22:11 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>
CC: "lenb@kernel.org" <lenb@kernel.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "mahesh@linux.ibm.com" <mahesh@linux.ibm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: RE: Questions: Should kernel panic when PCIe fatal error occurs?
Thread-Topic: Questions: Should kernel panic when PCIe fatal error occurs?
Thread-Index: AQHZ7Bag+I9/7O2gw0aXfXPFoWr8dLAl2OAA
Date: Thu, 21 Sep 2023 22:22:11 +0000
Message-ID: <625cdd6c55994bf3a50efd8f79680029@AcuMS.aculab.com>
References: <e486db16-d36d-9e14-4f10-dc755c0ef97d@linux.alibaba.com>
 <20230920230257.GA280837@bhelgaas>
In-Reply-To: <20230920230257.GA280837@bhelgaas>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> It would be nice if they worked the same, but I suspect that vendors
> may rely on the fact that CPER_SEV_FATAL forces a restart/panic as
> part of their system integrity story.

The file system errors created by a panic (especially an NMI panic)
could easily be more problematic than a failed PCIe data transfer.
Evan a read that returned ~0u - which can be checked for.

Panicking a system that is converting TDM telephony to RTP for the
911 emergency service because a PCIe cable/riser connecting one of the
TDM board has become loose doesn't seem ideal.
(Or because the TDM board's fpga has decided it isn't going to respond
to any accesses until the BARs are setup again...)

The system can carry on with some TDM connections disabled - but that
is ok because they are all duplicated in case a cable gets cuit.

(Yes - that is a live system...)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


